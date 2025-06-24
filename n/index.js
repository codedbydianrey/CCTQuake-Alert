/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// Export the Cloud Function
exports.sendEarthquakeNotification = functions.firestore
    .document('earthquake.data/{docId}')
    .onCreate((snap, context) => {
        // Extract data from the newly created document
        const data = snap.data();
        const intensity = data.intensity;
        const timestamp = data.timestamp;

        // Create notification payload
        const payload = {
            notification: {
                title: 'Earthquake Alert',
                body: `An earthquake of intensity ${intensity} was detected at ${timestamp}.`,
            },
            topic: 'earthquake_alerts',
        };

        // Send notification using Firebase Cloud Messaging (FCM)
        return admin.messaging().send(payload)
            .then(response => {
                console.log('Successfully sent message:', response);
            })
            .catch(error => {
                console.log('Error sending message:', error);
            });
    });
