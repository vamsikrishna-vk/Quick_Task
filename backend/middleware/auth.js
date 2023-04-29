const admin = require('firebase-admin');
const serviceAccount = require("../hello-768dc-firebase-adminsdk-aqlg3-406697abb4.json")
const authHandler = async (req, res, next) => {
  let token;
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });

  try {
    if (req.headers.authorization) {
      token = req.headers.authorization
    }
    if (!token) {
      res.send("no token found")
      return
    }
    const decodedToken = await admin.auth().verifyIdToken(token);
    const email = decodedToken.email;
    console.log(email);
    //  req.user = await User.findById(decodedJwtPayload._id, "name email role")
    next()
  } catch (error) {
    console.error('An error occurred:', error);
    return
  }
}
module.exports = { authHandler }