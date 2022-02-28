const mysql=require('mysql');
const dotenv=require('dotenv');

let instance=null;
dotenv.config();

const pool = mysql.createPool({
    host:"studentapp.mysql.database.azure.com",
    user:"studentappadmin",
    password:"@Root&DBBackendAdmin",
    database:"studentapp",
    port:3306
});

class Db_dept{
    static getDbServiceInstance(){
        return instance ? instance :new Db_dept();
    }

    async getAllData(clglink){
        try{
            const response=await new Promise((resolve,reject)=>{
                const query="select * from departments where college_link=?";
                pool.getConnection((err, connection) => { 
                    connection.query(query, [clglink],(error,results)=>{    
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

    async insertData(clglink,deptname,offno,uname,pass){
        try{

            const dateAdded=new Date();
            //update table rows and push this as well
           const response=await new Promise((resolve,reject)=>{
                const query="INSERT into departments (college_link,dept_name,office_help,dept_admin_username,dept_admin_password) values (?,?,?,?,?)";
                pool.getConnection((err, connection) => { 
                connection.query(query,[clglink,deptname,offno,uname,pass],(error,result)=>{    
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
                const query="Delete from departments where dept_id=?";
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
    async updateData(helpno, password, deptid){
        try{
            deptid=parseInt(deptid,10);
            const response=await new Promise((resolve,reject)=>{
                const query="update departments set office_help=? ,dept_admin_password=? where dept_id=?";
                pool.getConnection((err, connection) => { 
                connection.query(query,[helpno,password,deptid],(error,result)=>{    
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
                const query ="select dept_id from departments where dept_admin_username=? and dept_admin_password=?";
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
            // console.log(response);
            return response;

            // if (length==0){
            //     return "fail";
            // }
            // else {
            //     return "success"
            // }
        }catch(error){
            console.log(error);
        }
    }

}

module.exports=Db_dept;