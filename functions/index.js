const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotification = functions.firestore
    .document('earthquake.data/{docId}')
    .onCreate((snap, context) => {
        const newValue = snap.data();
        const payload = {
            notification: {
                title: 'Earthquake Alert',
                body: `Intensity: ${newValue.intensity} at ${newValue.timestamp}`,
            },
        };

        return admin.messaging().sendToTopic('earthquake_alerts', payload);
    });