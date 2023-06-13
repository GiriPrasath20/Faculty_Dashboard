  const express = require('express');
  const multer = require('multer');
  const mysql = require('mysql');
  const bodyParser = require('body-parser');
  const path = require('path');
  const fs = require('fs');
const csv = require('csv-writer').createObjectCsvWriter;
  const storage = multer.diskStorage({
    destination: 'uploads/',
    filename: function (req, file, cb) {
      cb(null, file.originalname);
    }
  });
  
  const upload = multer({ storage: storage });
  const app = express();
  const port = 3000;

  // Database connection configuration
  const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'faculty'
  });

  // Connect to the database
  connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to the database');
  });

  // Set up body-parser middleware
  app.use(bodyParser.json());

  // Set up body-parser middleware
  app.use(bodyParser.urlencoded({ extended: false }));

  // Serve static files from the 'public' directory
  app.use(express.static(path.join(__dirname, 'public')));

  // GET request handler for the root URL
  app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
  });

  app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError) {
      // Multer error occurred during file upload
      console.error('Multer Error:', err);
      res.status(500).json({ error: 'File upload failed' });
    } else {
      next(err);
    }
  });

  app.get('/download-attendance', (req, res) => {
    // Query the attendance table
    connection.query('SELECT * FROM attendance', (err, results) => {
      if (err) {
        console.error('Error fetching attendance data:', err);
        return;
      }
  
      // Process the retrieved attendance data
      const attendanceData = results;
  
      // Generate the CSV content
      let csvContent = 'ID,faculty_id,in_time,out_time\n';
      attendanceData.forEach((attendance) => {
        csvContent += `${attendance.ID},${attendance.faculty_id},${attendance.in_time},${attendance.out_time}\n`;
      });
  
      // Set the response headers
      res.setHeader('Content-Disposition', 'attachment; filename=attendance.csv');
      res.setHeader('Content-Type', 'text/csv');
  
      // Send the CSV content as the response
      res.send(csvContent);
    });
  });
  



// Endpoint for submitting leave application
app.post('/applyLeave', (req, res) => {
      console.log('Leave application submitted');
      res.status(200).json({ message: 'Leave application submitted successfully' });
});

// Endpoint for submitting bonafide application
app.post('/applyBonafide', (req, res) => {
  console.log('Bonafide Requested');
      res.status(200).json('Bonafide Requested');
});




  // POST request handler for the login form submission
  app.post('/login', (req, res) => {
    const email = req.body.username;
    const passcode = req.body.password;

    const query = 'SELECT * FROM login WHERE email = ? AND passcode = ?';
    connection.query(query, [email, passcode], (err, results) => {
      if (err) throw err;

      if (results.length > 0) {
        const user = results[0];
        const facultyId = user.faculty_id;
        const designation = user.designation;

        // Fetch user details from the 'details' table
        const userDetailsQuery = 'SELECT name, department FROM details WHERE faculty_id = ?';
        connection.query(userDetailsQuery, [facultyId], (err, userDetails) => {
          if (err) throw err;

          const name = userDetails[0].name;
          const department = userDetails[0].department;

          if (designation === 'admin') {
            // Redirect to the admin.html page and pass the user details and designation as query parameters
            res.redirect(`/admin.html?faculty_id=${facultyId}&designation=${designation}&name=${name}&department=${department}`);
          } 
          else if (designation === 'principal') {
            // Redirect to the principal.html page and pass the user details and designation as query parameters
            res.redirect(`/principal.html?faculty_id=${facultyId}&designation=${designation}&name=${name}&department=${department}`);
          }
          else {
            // Redirect to the dashboard.html page and pass the user details and designation as query parameters
            res.redirect(`/dashboard.html?faculty_id=${facultyId}&designation=${designation}&name=${name}&department=${department}`);
          }
        });
      } else {
        // If credentials are invalid, display an error message
        res.send('<script>alert("Invalid credentials. Please try again."); window.location.href = "login.html";</script>');
        
      }
    });
  });


  // GET request handler for retrieving profile based on faculty_id
  app.get('/profile/:faculty_id', (req, res) => {
    const facultyId = req.params.faculty_id;

    // Fetch profile data from the 'details' and 'education' tables
    const query = `
      SELECT 
        d.name,
        d.email,
        d.mobile_number,
        d.date_of_birth,
        CONCAT(d.address_city, ', ', d.address_state, ', ', d.address_pincode) AS address,
        d.blood_group,
        d.marital_status,
        e.bachelor_degree,
        e.masters_degree,
        e.research,
        d.designation
      FROM details AS d
      LEFT JOIN education AS e ON d.faculty_id = e.faculty_id
      WHERE d.faculty_id = ?
    `;

    connection.query(query, [facultyId], (err, results) => {
      if (err) throw err;

      if (results.length > 0) {
        const profileData = results[0];

        // Send the profile data as JSON response
        res.json(profileData);
      } else {
        res.status(404).send('Profile not found');
      }
    });
  });

  // POST request handler for changing the password
  app.post('/changePassword', (req, res) => {
    const facultyId = req.body.facultyId;
    const newPassword = req.body.newPassword;

    // Construct the SQL query to update the password in the login table
    const updatePasswordQuery = 'UPDATE login SET passcode = ? WHERE faculty_id = ?';

    // Execute the update query
    connection.query(updatePasswordQuery, [newPassword, facultyId], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Failed to update password' });
      }

      console.log('Password updated successfully');

      // Return a success response
      res.json({ success: true });
    });
  });


  // POST request handler for saving edited details
  app.post('/saveDetails', (req, res) => {
    const facultyId = req.body.facultyId; // Retrieve faculty ID from the form data
    const {
      name,
      mobileNumber,
      dateOfBirth,
      address,
      bloodGroup,
      maritalStatus,
      bachelorDegree,
      masterDegree,
      research
    } = req.body; // Retrieve the edited details from the form data

    // Construct the SQL queries to update the 'details' and 'education' tables
    const updateDetailsQuery = `
      UPDATE details
      SET name = ?,
          mobile_number = ?,
          date_of_birth = ?,
          address = ?,
          blood_group = ?,
          marital_status = ?
      WHERE faculty_id = ?
    `;

    const updateEducationQuery = `
      UPDATE education
      SET bachelor_degree = ?,
          masters_degree = ?,
          research = ?
      WHERE faculty_id = ?
    `;

    // Execute the update queries
    connection.query(
      updateDetailsQuery,
      [name, mobileNumber, dateOfBirth, address, bloodGroup, maritalStatus, facultyId],
      (err) => {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: 'Failed to update details' });
        }

        connection.query(
          updateEducationQuery,
          [bachelorDegree, masterDegree, research, facultyId],
          (err) => {
            if (err) {
              console.error(err);
              return res.status(500).json({ error: 'Failed to update education' });
            }

            console.log('Details and education updated successfully');

            // Return a success response
            res.json({ success: true });
          }
        );
      }
    );
  });


  app.post('/updateDetails', (req, res) => {

        console.log('Details updated successfully');
      
    });


    app.post('/uploadExam', (req, res) => {
      // File upload successful
      console.log('Paper uploaded successfully!');
      res.status(200).json('Paper uploaded successfully!');
    });

  // Handle the profile update request
  app.post('/updateProfile', (req, res) => {  
    const facultyId = req.body.facultyId;
    const updatedProfile = {
      name: req.body.name,
      email: req.body.email,
      mobile_number: req.body.mobileNumber,
      date_of_birth: req.body.dateOfBirth,
      blood_group: req.body.bloodGroup,
      marital_status: req.body.maritalStatus,
      address_city: '',
      address_state: '',
      address_pincode: ''
    };

    const addressParts = req.body.address.split(',').map(part => part.trim());
    if (addressParts.length === 3) {
      updatedProfile.address_city = addressParts[0];
      updatedProfile.address_state = addressParts[1];
      updatedProfile.address_pincode = addressParts[2];
    }

    const updatedEducation = {
      bachelor_degree: req.body.bachelorDegree,
      masters_degree: req.body.masterDegree,
      research: req.body.research
    };

    // Update the database with the edited profile
    const detailsQuery = 'UPDATE details SET ? WHERE faculty_id = ?';
    const educationQuery = 'UPDATE education SET ? WHERE faculty_id = ?';

    connection.beginTransaction((error) => {
      if (error) {
        console.log(error);
        res.status(500).json({ error: 'An error occurred while updating the profile' });
      } else {
        connection.query(detailsQuery, [updatedProfile, facultyId], (error, result) => {
          if (error) {
            connection.rollback(() => {
              console.log(error);
              res.status(500).json({ error: 'An error occurred while updating the profile' });
            });
          } else {
            connection.query(educationQuery, [updatedEducation, facultyId], (error, result) => {
              if (error) {
                connection.rollback(() => {
                  console.log(error);
                  res.status(500).json({ error: 'An error occurred while updating the profile' });
                });
              } else {
                connection.commit((error) => {
                  if (error) {
                    connection.rollback(() => {
                      console.log(error);
                      res.status(500).json({ error: 'An error occurred while updating the profile' });
                    });
                  } else {
                    res.json(updatedProfile);
                  }
                });
              }
            });
          }
        });
      }
    });
  });


  // GET request handler for retrieving salary based on faculty_id
  app.get('/salary/:facultyId', (req, res) => {
    const facultyId = req.params.facultyId;

    // Query to fetch the salary data based on faculty ID
    const query = 'SELECT basic_salary, taxes, monthly_salary FROM salary WHERE faculty_id = ?';

    connection.query(query, [facultyId], (err, results) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Failed to fetch salary data' });
      }

      if (results.length === 0) {
        return res.status(404).json({ error: 'Salary data not found' });
      }

      const salaryData = results[0];
      res.json(salaryData);
    });
  });

  // GET request handler for retrieving task based on faculty_id
  app.get('/task/:faculty_id', (req, res) => {
    const facultyId = req.params.faculty_id;
    const query = 'SELECT task_description FROM task WHERE faculty_id = ?';

    connection.query(query, [facultyId], (err, results) => {
      if (err) throw err;

      const taskDescriptions = results.map((row) => row.task_description);

      res.json(taskDescriptions);
    });
  });

  // POST request handler for adding a task
  app.post('/addTask', (req, res) => {
    const facultyId = req.body.facultyId; // Retrieve faculty ID from the form data
    const taskDescription = req.body.taskDescription; // Retrieve task description from the form data

    // Construct the SQL query to insert the task data
    const insertQuery = 'INSERT INTO task (faculty_id, task_description) VALUES (?, ?)';

    // Execute the insert query
    connection.query(insertQuery, [facultyId, taskDescription], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Failed to add task' });
      }

      console.log('Task added successfully');

      // Return a success response
      res.json({ success: true });
    });
  });

  // POST request handler for storing attendance data
  app.post('/attendance', (req, res) => {
    const { facultyId, inTime, outTime } = req.body;

    // Construct the SQL query to insert the attendance data
    const insertQuery = 'INSERT INTO attendance (faculty_id, in_time, out_time) VALUES (?, ?, ?)';

    // Execute the insert query
    connection.query(insertQuery, [facultyId, inTime, outTime], (err, result) => {
      if (err) {
        console.error(err);
        return res.status(500).json({ error: 'Failed to store attendance data' });
      }

      console.log('Attendance data stored successfully');

      // Return a success response
      res.json({ success: true });
    });
  });



  app.post('/materials', upload.single('file_data'), (req, res) => {
    const file = req.file;
    const fileName = req.body.file_name;
    const fileSize = req.body.file_size;
    const facultyId = req.body.faculty_id;

    // Insert the file details into the database
    const query = 'INSERT INTO materials (file_name, file_size, faculty_id) VALUES (?, ?, ?)';
    connection.query(query, [fileName, fileSize, facultyId], (err, results) => {
      if (err) {
        console.error('Error inserting file details:', err);
        res.status(500).json({ success: false, message: 'Error uploading file' });
      } else {
        console.log('File details inserted into the database');
        res.json({ success: true, message: 'File uploaded successfully' });
      }
    });
  });


  app.use(express.urlencoded({ extended: true }));
  app.use(express.json());

  // Route for creating a new user
  app.post('/createUser', (req, res) => {
    const { faculty_id, name, email, passcode, designation, basic_salary } = req.body;

    // Validate the inputs if needed

    // Prepare the SQL query to insert the new user into the details table
    const detailsQuery = 'INSERT INTO details (faculty_id, name, email, designation) VALUES (?, ?, ?, ?)';
    const detailsValues = [faculty_id, name, email, designation];

    // Prepare the SQL query to insert the new user into the login table
    const loginQuery = 'INSERT INTO login (faculty_id, email, passcode, designation) VALUES (?, ?, ?, ?)';
    const loginValues = [faculty_id, email, passcode, designation];

    // Prepare the SQL query to insert the basic salary into the salary table
  const salaryQuery = 'INSERT INTO salary (faculty_id, designation, basic_salary) VALUES (?, ?, ?)';
  const salaryValues = [faculty_id, designation, basic_salary];

  const educationQuery = 'INSERT INTO education (faculty_id) VALUES (?)';
  const educationValue = [faculty_id];


    // Execute the queries
    connection.query(detailsQuery, detailsValues, (err, detailsResult) => {
      if (err) {
        console.error('Error creating a new user in the details table: ', err);
        res.status(500).json({ success: false, message: 'Error creating a new user' });
        return;
      }

      connection.query(loginQuery, loginValues, (err, loginResult) => {
        if (err) {
          console.error('Error creating a new user in the login table: ', err);
          res.status(500).json({ success: false, message: 'Error creating a new user' });
          return;
        }

        connection.query(salaryQuery, salaryValues, (err, salaryResult) => {
          if (err) {
            console.error('Error inserting basic salary in the salary table: ', err);
            res.status(500).json({ success: false, message: 'Error creating a new user' });
            return;
          }

          connection.query(educationQuery, educationValue, (err, educationResult) => {
            if (err) {
              console.error('Error inserting basic salary in the salary table: ', err);
              res.status(500).json({ success: false, message: 'Error creating a new user' });
              return;
            }

          console.log('New user created successfully');
          res.json({ success: true, message: 'New user created successfully' });
        });
      });
    });
  });
  });



  // Route to fetch the list of advisors/faculty members
  app.get('/advisors', (req, res) => {
    // Assuming you have a table called `details` containing advisor/faculty details
    const query = 'SELECT faculty_id, name, designation FROM details';

    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error fetching advisors:', err);
        res.status(500).json({ success: false, message: 'Failed to fetch advisors' });
        return;
      }

      res.json(results);
    });
  });

  // Route to delete a user by faculty ID
  app.delete('/deleteUser/:facultyId', (req, res) => {
    const facultyId = req.params.facultyId;

    // Prepare the SQL query to delete the user from multiple tables based on faculty ID
    const deleteQuery = 'DELETE FROM login WHERE faculty_id = ?';
    const deleteQueries = [
      deleteQuery,
      'DELETE FROM education WHERE faculty_id = ?',
      'DELETE FROM salary WHERE faculty_id = ?',
      'DELETE FROM login WHERE faculty_id = ?',
      'DELETE FROM task WHERE faculty_id = ?' ,
      'DELETE FROM details WHERE faculty_id = ?'
    ];

    // Execute the delete queries in a transaction
    connection.beginTransaction((err) => {
      if (err) {
        console.error('Error starting database transaction:', err);
        res.status(500).json({ success: false, message: 'Failed to delete user' });
        return;
      }

      // Execute each delete query in the transaction
      deleteQueries.forEach((query) => {
        connection.query(query, [facultyId], (err) => {
          if (err) {
            connection.rollback(() => {
              console.error('Error deleting user:', err);
              res.status(500).json({ success: false, message: 'Failed to delete user' });
            });
            return;
          }
        });
      });

      // Commit the transaction if all queries executed successfully
      connection.commit((err) => {
        if (err) {
          connection.rollback(() => {
            console.error('Error committing database transaction:', err);
            res.status(500).json({ success: false, message: 'Failed to delete user' });
          });
          return;
        }

        console.log('User deleted successfully');
        res.json({ success: true, message: 'User deleted successfully' });
      });
    });
  });



  // Start the server
  app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
  });
