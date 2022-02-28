const express=require('express');
const app=express();
const cors=require('cors');
const dotenv=require('dotenv');
const { response } = require('express');
const port=process.env.PORT ||5000;
dotenv.config();

const db_service=require('./db_service');

const db_dept=require('./db_service_departments');

const db_section=require('./db_service_sections.js');
const db_studentui=require('./db_service_studentui.js');

app.use(cors()); //to not block cors requests
app.use(express.json());
app.use(express.urlencoded({extended:false}));

//--------------------------------------------------------------------
//----------------------Root Config-----------------------------------
//--------------------------------------------------------------------
//insert data route
app.post('/insert',async(request,response)=>{
    const {name,about,userid,password}=request.body;
    const db=db_service.getDbServiceInstance();
    const result=db.insertData(name,about,userid,password);

    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});


//fetch data route
app.get('/getall',(request,response)=>{
    console.log('getall running');
    const db=db_service.getDbServiceInstance();
    const result=db.getAllData();
    console.log(result);
    result.then(data =>response.json({data:data}))
    .catch(error=>console.log(error));
    // console.log(result);
    // return response.json({data:result});
});

//update data route
app.post('/update',async(request,response)=>{
    console.log('update running');
    const {name,about,id,password,userid,bigpicture}=request.body;
    console.log(id);
    console.log(bigpicture);
    const db=db_service.getDbServiceInstance();
    const result=db.updateData(name,about,id,password,userid,bigpicture);
    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});


//delete
app.post('/delete',async(request,response)=>{
    const {id}=request.body;
    console.log(id);
    const db=db_service.getDbServiceInstance();
    const result=db.deleteData(id);
    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});

//login
app.post('/login',async(request,response)=>{
    const {userid,password}=request.body;
    console.log(userid);
    console.log(password);
    const db=db_service.getDbServiceInstance();
    const result=db.checkLogin(userid,password);
    result.then(data =>{
        if(data.length==1)
            return response.json({ result: "success" })
        else
            return response.json({ result: "fail" })
    }
    )
    .catch(error=>console.log(error));
});
//---------------------------------------------------------------------------
//----------------------Department config------------------------------------
//---------------------------------------------------------------------------
app.post('/dept/insert',async(request,response)=>{
    const {clglink,deptname,offno,uname,pass}=request.body;
    const db=db_dept.getDbServiceInstance();
    const result=db.insertData(clglink,deptname,offno,uname,pass);

    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});

//fetch data route
app.post('/dept/getall',(request,response)=>{
    const {clglink}=request.body;
    console.log('getall running');
    const db=db_dept.getDbServiceInstance();
    const result=db.getAllData(clglink);
    console.log(result);
    result.then(data =>response.json({data:data}))
    .catch(error=>console.log(error));
    // console.log(result);
    // return response.json({data:result});
});

//update data route
app.post('/dept/update',async(request,response)=>{
    console.log('update running');
    const {helpno, password, deptid}=request.body;
    // console.log(id);
    // console.log(bigpicture);
    const db=db_dept.getDbServiceInstance();
    const result = db.updateData(helpno, password, deptid);
    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});


//delete
app.post('/dept/delete',async(request,response)=>{
    const {id}=request.body;
    console.log(id);
    const db=db_dept.getDbServiceInstance();
    const result=db.deleteData(id);
    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});

//login
app.post('/dept/login',async(request,response)=>{
    const {userid,password}=request.body;
    console.log(userid);
    console.log(password);
    const db=db_dept.getDbServiceInstance();
    const result=db.checkLogin(userid,password);
    result.then(data =>response.json({result:data}))
    .catch(error=>console.log(error));
});
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
//----------------------Section config------------------------------------
//---------------------------------------------------------------------------
app.post('/dept/section/insert', async (request, response) => {
    const { dept_link, section_name, section_batch_join, section_code } = request.body;
    const db = db_section.getDbServiceInstance();
    const result = db.insertData(dept_link, section_name, section_batch_join, section_code);
    result.then(data => response.json({ result: "success" }))
        .catch(error => console.log(error));
});

//fetch data route
app.post('/dept/section/getall', async (request, response) => {
    const { deptlink } = request.body;
    console.log('getall running');
    const db = db_section.getDbServiceInstance();
    const result = db.getAllData(deptlink);
    console.log(result);
    result.then(data => response.json({ data: data }))
        .catch(error => console.log(error));
    // console.log(result);
    // return response.json({data:result});
});

//update data route
app.post('/dept/section/update', async (request, response) => {
    console.log('update running');
    const { section_name, year, section_id } = request.body;
    // console.log(id);
    // console.log(bigpicture);
    const db = db_section.getDbServiceInstance();
    const result = db.updateData(section_name, year, section_id);
    result.then(data => response.json({ result: "success" }))
        .catch(error => console.log(error));
});


//delete
app.post('/dept/section/delete', async (request, response) => {
    const { id } = request.body;
    console.log(id);
    const db = db_section.getDbServiceInstance();
    const result = db.deleteData(id);
    result.then(data => response.json({ result: "success" }))
        .catch(error => console.log(error));
});

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
//----------------------Student UI config------------------------------------
//---------------------------------------------------------------------------

//login
app.post('/student/login',async(request,response)=>{
    const {username,password}=request.body;
    console.log(username);
    console.log(password);
    const db=db_studentui.getDbServiceInstance();
    const result=db.processSignin(username,password);
    result.then(data =>response.json({result:data}))
    .catch(error=>console.log(error));
});

//signup
app.post('/student/insert',async(request,response)=>{
    const {email,password,name,usn,classcode}=request.body;
    const db=db_studentui.getDbServiceInstance();
    const result=db.processSignup(email,password,name,usn,classcode);
    result.then(data =>response.json({result:"success"}))
    .catch(error=>console.log(error));
});

//signup
app.post('/student/tasks/insert', async (request, response) => {
    const {tskname, tskdescription, date, section_link} = request.body;
    const db = db_studentui.getDbServiceInstance();
    const result = db.processInsertTask(tskname, tskdescription, date, section_link);
    result.then(data => response.json({ result: "success" }))
        .catch(error => console.log(error));
});

//gettasks
app.post('/student/tasks/get', async (request, response) => {
    const { class_link } = request.body;
    const db = db_studentui.getDbServiceInstance();
    const result = db.processGetTask(class_link);
    result.then(data => response.json({ result: data }))
        .catch(error => console.log(error));
});


// the app uses this port to listen and respond to requests
app.listen(port,()=>{
    console.log("App is running");
    } 
);
