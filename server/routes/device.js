const express = require('express');
const router = express.Router();
const Device = require('../models/Device');
const moment = require('moment');

// router.get('/', auth(['customer', 'admin']), async (req, res) => {
router.get('/listDevice', async (req, res) => {
    try {
        Device.find({deviceOwner: req.query.email}, function(err, devices) {
            return res.status(200).json({
                devices,
            });
          });
    
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});

router.get('/deviceRequestFix', async (req, res) => {
    try {
        if(req.query.email ==null || req.query.email =='' ){
            Device.find({ status:false }, function(err, devices) {
                return res.status(200).json({
                    length: devices.length,
                    devices,
                });
              });
        }else Device.find({deviceOwner: req.query.email, status:false }, function(err, devices) {
            return res.status(200).json({
                length: devices.length,
                devices,
            });
          });
    
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});
router.patch('/update/:id', async (req, res) => {
    try {
        Device.findOneAndUpdate({_id: req.params.id},
            {
                $set : req.body
            },
            { new: true },
            (err, user) =>{
                if (err) {
                    res.status(400).json({ message: err });
                  } else  res.status(200).json({
                    user
                });
            }  
           
        );
        
    
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
});


router.post('/create', async (req, res) => {
    //Validate schema before add a user
    const device = new Device({
        name: req.body.name,
        deviceOwner: req.body.deviceOwner,
        description: req.body.description,
        installationDate: req.body.installationDate,
        note: req.body.note,
        status: req.body.status
    });
    try {
        const savedDevice = await device.save();
        res.status(200).json(savedDevice);
    } catch (err) {
        res.status(400).json({ message: err.message });
    }
});

module.exports = router;
