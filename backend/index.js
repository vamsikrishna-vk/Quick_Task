const express = require("express")
const mongoose = require("mongoose")
const axios = require("axios")
const authHandler = require("./middleware/auth")
const user = require("./models/user")
const app = express()
const port = 8080

app.use(express.json());

app.use(express.urlencoded({ extended: true }));

app.get("/home", async (req, res) => {
  res.send("hello")
  return
})
/**
* this is to add all new friends to the list
*
 * @body {nick} - to give nickname to your friend.
 * @body {friend_email} - The give the email address of the friend.
 * @body {self_email} - To Provide the email address from the firebase login.

 * @returns {json} - The updated version of the user.
 */

app.post("/makeFriend", async (req, res) => {
  const { nick, friend_email, self_email } = req.body
  const find_me = await user.findOne({ email: self_email })
  const updated = find_me.friends.push({ email: friend_email, nickname: nick })
  await find_me.save()
  res.send(find_me)
})

/**
* //will send the body to the flask store res in db if succ store in db
*
 * @body {sendermail} - to get the email address of the person it is assigned to.
 * @body {message} - to get the message/task that will be sent.
 * @body {nickname} - To Provide the email address from the firebase login.
 * @body {email} - To Provide the email address from the firebase login.
 * @returns {string("SUCESS"/"Failure")} - The updated version of the user.
 */

app.post("/sendMessage", async (req, res) => {
  const { senderemail, message, nickname, email } = req.body
  axios.post('http://10.10.10.218:5000/getIntent', { senderName: nickname, message })
    .then(async function (response) {
      // if successful then log the response status and data
      console.log(response.data)
      if (response.data.intent == "NA" || response.data.timing == "NA") {
        res.status(203).send("Failure")
      } else {
        const get_user = await user.findOne({ email: senderemail });
        console.log(get_user)
        console.log(get_user.tasks)
        const updated = get_user.tasks.push({ intent: response.data.intent, message, sender: email, time: response.data.timing })
        await get_user.save()
        console.log(updated)
        res.send("Success")
      }
    })
    .catch(function (error) {
      console.log("flask server is failing")
      console.log(error);
    })
})

// take intent from body and set it in db
app.post("/setData", async (req, res) => {
  const { intent, timing, sender_email, user_email } = req.body
  const sender_user = await user.findOne({ sender_email });
  const newtask = new task({ intent, timing, sender: sender_user })
  await newtask.save()
  const hello = await user.findOne({ email: user_email });
  hello.tasks.push(newtask._id);
  await hello.save()
  res.json(hello)

})


//will create the user and the docs will come in req.body
app.post('/setpref', async (req, res) => {
  const newuser = new user({ name: "hello123", email: "hello@gmail.com" })
  newuser.save()
  res.send(newuser)
})
//
app.post('/settask', async (req, res) => {
  const { id, tasks, userId } = req.body
  const newtask = new task(tasks)
  await task.save()
  const user = await usersModel.findById(userId);
  user.tasks.push(newTask._id);
  await user.save()
  res.json(doc)
})
//will get all teh tasks of a particular user send in body
app.post('/getalltask', async (req, res) => {
  const { user_email } = req.body
  console.log(req.body)
  const retdata = await user.findOne({ email: user_email })
  if (retdata == null) {
    res.send([])
    return
  }
  console.log(retdata.tasks)
  res.json(retdata.tasks)
  return
})
//will get all the data about the friends of user supplied in th req .body
app.post("/getallProfile", async (req, res) => {
  const { email } = req.body
  const user_data = await user.findOne({ email })
  if (user_data == null) {
    res.send([])
    return
  }
  res.send(user_data.friends)
})
app
try {
  mongoose.connect('mongodb://127.0.0.1:27017/backend');
  console.log("database is connected")
  app.listen(port, "10.10.10.225", () => {
    console.log("the server is online")
  })

} catch (error) {
  console.log("database connection failed")
}

