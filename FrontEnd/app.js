const getBuses = require('./src/queries')  ;
const express = require("express");
const app = express();
const path = require("path");
const bodyParser = require("body-parser");
app.use("/static", express.static(__dirname));
app.use(express.static(path.join(__dirname + "/public")));
app.use(bodyParser.urlencoded({ extended: true }));


//getBuses().then(function(result) {console.log(result);});

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "/public/index.html"));
});

app.get("/dashboard",(req,res)=>{
  res.sendFile(path.join(__dirname, "/public/dashboard.html"));
});

const port = 3000;
app.listen(port, () => console.log(`Running on port http://localhost:${port}`));
