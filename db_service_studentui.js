const mysql = require('mysql');
const dotenv = require('dotenv');

let instance = null;
dotenv.config();

const pool = mysql.createPool({
    host:"studentapp.mysql.database.azure.com",
    user:"studentappadmin",
    password:"@Root&DBBackendAdmin",
    database:"studentapp",
    port:3306
});

class Db_studentui {
    static getDbServiceInstance() {
        return instance ? instance : new Db_studentui();
    }

    async processSignin(username,password) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "select id,class_link from student_auth_table where student_email=? and student_password=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [username,password], (error, results) => {
                        connection.release();
                        if (error) {
                            reject(new Error(error.message));
                        }
                        resolve(results);
                    })
                });
            });
            // console.log(response);
            return (response);

        }
        catch (error) {
            console.log(error);
        }
    }

    async processSignup(email,password,name,usn,classcode) {
        try {
            // const dateAdded = new Date();
            //update table rows and push this as well
            const response = await new Promise((resolve, reject) => {
                const query = "INSERT into student_auth_table (student_email,student_password,student_name,id,auth_level,class_link) values (?,?,?,?,0,(select section_id from sections where section_classcode=?))";
                pool.getConnection((err, connection) => {
                    connection.query(query, [email,password,name,usn,classcode], (error, result) => {
                        connection.release();
                        if (error) {
                            reject(new Error(error.message));
                        }
                        resolve(result.insertId);
                    })
                });
            });
            console.log(response); //response is the inserted id
            return {
                id: response,
                name: name,
                about: about,
                userid: userid,
                password: password
            };
        }
        catch (error) {
            console.log(error);
        }
    }

    async processInsertTask(tskname,tskdescription,date,section_link) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "INSERT into tasks (section_link,task_name,task_description,task_deadline) values (?,?,?,?)";
                pool.getConnection((err, connection) => {
                    connection.query(query, [section_link,tskname,tskdescription,date], (error, result) => {
                        connection.release();
                        if (error) {
                            reject(new Error(error.message));
                        }
                        resolve(result.insertId);
                    })
                });
            });
            console.log(response); //response is the inserted id
            return {
                task_id: response,
                task_name: tskname,
                task_description: tskdescription,
                task_deadline: date,
            };
        }
        catch (error) {
            console.log(error);
        }
    }

    async processGetTask(class_link) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "SELECT task_id AS id,task_name AS name,task_description AS description FROM tasks WHERE section_link=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [class_link], (error, result) => {
                        connection.release();
                        if (error) {
                            reject(new Error(error.message));
                        }
                        resolve(result);
                    })
                });
            });
            console.log(response);
            return response;
        }
        catch (error) {
            console.log(error);
        }
    }


    
    async editProfile(section_name, year, section_id) {
        try {
            section_id = parseInt(section_id, 10);
            const response = await new Promise((resolve, reject) => {
                const query = "update sections set section_name=?,section_batch_join=? where section_id=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [section_name, year, section_id], (error, result) => {
                        connection.release();
                        if (error) {
                            reject(new Error(error.message));
                        }
                        resolve(result);
                    })
                });
            });
        } catch (error) {
            console.log(error);
        }
    }

}

module.exports = Db_studentui;