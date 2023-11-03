/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onSchedule} = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

admin.initializeApp();

const PromisePool = require("es6-promise-pool").default;
const MAX_CONCURRENT = 3;

exports.matchalarm = onSchedule("every day 12:00", async (event) => {
	const tag = "BOO"

	var today = new Date();
	//10월 14일 (토), 2월 1일 (목) 
	var month = today.getMonth() + 1;
	var day = today.getDate();
	var d = today.getDay();

	var weekday=new Array(7);
    weekday[0]="일";
    weekday[1]="월";
    weekday[2]="화";
    weekday[3]="수";
    weekday[4]="목";
    weekday[5]="금";
    weekday[6]="토";

	var dateString = month + '월 ' + day + '일' + '(' + weekday[d] + ')';

	logger.log(tag, "dateString : " + dateString);
	
	var manMatchJson = admin.database().ref(`/ManSchedule/${dateString}`).toJson();
	var manMatchMsg = '';
	if (manMatchJson != null) {
		var manMatchObj = JSON.parse(manMatchJson);
		manMatchMsg = manMatchObj.time + ' ' + manMatchObj.home_team + ' vs ' + manMatchObj.away_team;
	}

	var womanMatchJson = admin.database().ref(`/WomanSchedule/${dateString}`).toJson();
	var womanMatchMsg = '';

	if(womanMatchJson != null) {
		var womanMatchObj = JSON.parse(womanMatchJson);
		womanMatchMsg = womanMatchObj.time + ' ' + womanMatchObj.home_team + ' vs ' + womanMatchObj.away_team;
	}

	if(manMatchMsg != '' || womanMatchMsg != '') {
		const pushMsg = manMatchMsg + '\n' + womanMatchMsg;
		const FCMToken = '';
		const payload = {
			token: FCMToken,
			notification: {
				title: '오늘의 배구경기',
				body : pushMsg
			}
		};

		admin.messaging().send(payload).then((response) => {
			//Response is a message ID string.
			logger.log(tag, 'Successfully sent message: ', response);
			return {success: true};
		}).catch((error) => {
			logger.log(tag, 'Successfully sent message: ', error.code);
			return {error: error.code};
		});
	}

})

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
