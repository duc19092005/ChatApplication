import express from "express"
import { Request , Response } from "express";

const port = 5000;
const app = express()

app.get('/' , (req : Request , res : Response) => {
    res.status(200)
})

app.listen(port , (error) => {
    if(!error)
        console.log("Server is Successfully Running and App is listening on port "+ port);
    else 
        console.log("Error occurred, server can't start", error);
    });




