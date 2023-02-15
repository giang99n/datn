const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
	name: {
		type: String,
		required: true,

	},
	deviceOwner: {
		type: String,
		required: true,
	},
    description:{
		type: String,
		required: true,
	},
	note:{
		type: String,
	},
	installationDate:{
		type: String,
		required: true,
	},
	status:{
		type: Boolean,
	},

});

module.exports = mongoose.model('Device', userSchema);
