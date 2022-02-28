const mysql=require('mysql');
const dotenv=require('dotenv');

//not wanting mutiple instances of below object
let instance=null;
dotenv.config();


const pool = mysql.createPool({
    host:"studentapp.mysql.database.azure.com",
    user:"studentappadmin",
    password:"@Root&DBBackendAdmin",
    database:"studentapp",
    port:3306
});



class Db_Service{
    static getDbServiceInstance(){
        return instance ? instance :new Db_Service();
    }

    async getAllData(){
        try{
            const response=await new Promise((resolve,reject)=>{
                const query="select college_id as id,college_name as name,about_college as about,college_admin_name as username,college_admin_password as password,bigpicture_college as bigpicture from colleges";
                pool.getConnection((err, connection) => {
                connection.query(query,(error,results)=>{
                    connection.release();
                    if(error){
                        reject(new Error(error.message));
                    }
                    resolve(results);
                })
            });
            });
            // console.log(response);
            return(response);

        }
        catch(error){
            console.log(error);
        }
    }

    async insertData(name,about,userid,password){
        try{

            const dateAdded=new Date();
            //update table rows and push this as well
           const response=await new Promise((resolve,reject)=>{
                const query="INSERT into colleges (college_name,about_college,college_admin_name,college_admin_password) values (?,?,?,?)";
                pool.getConnection((err, connection) => {
                connection.query(query,[name,about,userid,password],(error,result)=>{
                    connection.release();
                    if(error){
                        reject(new Error(error.message));
                    }
                    resolve(result.insertId);
                })
            });
            });
            console.log(response); //response is the inserted id
            return {
                id:response,
                name:name,
                about:about,
                userid:userid,
                password:password
            };
        }
        catch(error){
            console.log(error);
        }
    }

    async deleteData(id){
        try{
            id=parseInt(id,10);
            const response=await new Promise((resolve,reject)=>{
                const query="Delete from colleges where college_id=?";
                pool.getConnection((err, connection) => {
                connection.query(query,[id],(error,result)=>{
                    connection.release();
                    if(error){
                        reject(new Error(error.message));
                    }
                    resolve(result);
                })
                });
            });
        }catch(error){
            console.log(error);
        }
    }
    async updateData(name,about,id,password,userid,bigpicture){
        try{
            id=parseInt(id,10);
            const response=await new Promise((resolve,reject)=>{
                const query="update colleges set college_name=? , about_college=? ,college_admin_password=? , college_admin_name=?,bigpicture_college=? where college_id=?";
                pool.getConnection((err, connection) => {
                connection.query(query,[name,about,password,userid,bigpicture,id],(error,result)=>{
                    connection.release();
                    if(error){
                        reject(new Error(error.message));
                    }
                    resolve(result);
                })
            });
            });
        }catch(error){
            console.log(error);
        }
    }


    async checkLogin(userid,pass){
        try{
            let length=0;
            const response=await new Promise((resolve,reject)=>{
                const query="select college_id from colleges where college_admin_name=? and college_admin_password=?";
                pool.getConnection((err, connection) => {
                connection.query(query,[userid,pass],(error,result)=>{
                    connection.release();
                    length=result.length;
                    if(error){
                        reject(new Error(error.message));
                    }
                    resolve(result);
                })
            });
            });
            console.log(response);
            return response;

            // if (length==0){
            //     return "-1";
            // }
            // else {
            //     return response;
            // }
        }catch(error){
            console.log(error);
        }
    }

}

module.exports=Db_Service;
