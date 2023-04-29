const mongoose = require("mongoose")
const taskSchema = new mongoose.Schema({
  intent: {
    type: String
  },
  message: {
    type: String,
  },
  sender: {
    type: String,
  },
  time: {
    type: String
  }
});
const friendSchema = new mongoose.Schema({
  email: {
    type: String
  },
  nickname: {
    type: String,
    trim: true
  }
});
const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, "Primary name must be provided"],
      trim: true,
      maxLength: [
        120,
        "Name Length should not be more than 120 characters",
      ],
    },
    email: {
      type: String,
      unique: true,
      required: [true, "email must be provided"],
      trim: true,
      maxLength: [
        120,
        "Name Length should not be more than 120 characters",
      ],
    },
    friends: [],
    tasks: []
  },
  { timestamps: true }
);
module.exports = mongoose.model("user", userSchema);
