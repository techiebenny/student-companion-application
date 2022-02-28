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
class Db_section {
    static getDbServiceInstance() {
        return instance ? instance : new Db_section();
    }

    async getAllData(deptlink) {
        try {
            const response = await new Promise((resolve, reject) => {
                const query = "select section_id,section_name,section_batch_join,section_classcode from sections where dept_link=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [deptlink], (error, results) => {
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

    async insertData(dept_link,section_name,section_batch_join,section_code) {
        try {

            const dateAdded = new Date();
            //update table rows and push this as well
            const response = await new Promise((resolve, reject) => {
                const query = "INSERT into sections (dept_link,section_name,section_batch_join,section_classcode) values (?,?,?,?)";
                pool.getConnection((err, connection) => {
                    connection.query(query, [dept_link,section_name,section_batch_join,section_code], (error, result) => {
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

    async deleteData(id) {
        try {
            id = parseInt(id, 10);
            const response = await new Promise((resolve, reject) => {
                const query = "Delete from sections where section_id=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [id], (error, result) => {
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
    async updateData(section_name, year, section_id) {
        try {
            section_id = parseInt(section_id, 10);
            const response = await new Promise((resolve, reject) => {
                const query = "update sections set section_name=?,section_batch_join=? where section_id=?";
                pool.getConnection((err, connection) => {
                    connection.query(query, [section_name,year,section_id], (error, result) => {
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

module.exports = Db_section;