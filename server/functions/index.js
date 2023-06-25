const functions = require("firebase-functions");
const stripe = require('stripe')(functions.config().stripe.testkey)

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const admin = require('firebase-admin');
admin.initializeApp();

const calculatedOrderAmount = async (taskId) => {
  try {
    const taskSnapshot = await admin.firestore().collection('tasks').doc(taskId).get();
    if (taskSnapshot.exists) {
      const taskData = taskSnapshot.data();
      const budget = taskData.budget;

      const orderAmount = budget * 100;

      return orderAmount;
    }
    throw new Error(`Task with ID '${taskId}' does not exist.`);
  } catch (error) {
    throw new Error(`Failed to retrieve the budget: ${error}`);
  }
};



const generateResponse = function (intent) {
    switch (intent.status) {
        case 'requires_action':
            return {
                clientSecret: intent.clientSecret,
                requiresAction: true,
                status: intent.status,
            };
        case 'requires_payment_method':
            return {
                'error': 'Your card was denied, please provide a new payment method',
            };
        case 'succeeded':
            console.log('Payment succeeded.');
            return { clientSecret: intent.clientSecret, status: intent.status, };
    }
    return { error: 'Failed' };
}

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
    const { paymentMethodId, items, currency, useStripeSdk } = req.body;
  
    try {
      const orderAmount = 1200;
  
      if (paymentMethodId) {
        const params = {
          amount: orderAmount,
          confirm: true,
          confirmation_method: 'manual',
          currency: currency,
          payment_method: paymentMethodId,
          use_stripe_sdk: useStripeSdk,
        };
        const intent = await stripe.paymentIntents.create(params);
        console.log(`Intent: ${intent}`);
        return res.send(generateResponse(intent));
      }
  
      return res.sendStatus(400);
    } catch (e) {
      return res.send({ error: e.message });
    }
  });
  


exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
    const { paymentIntentId } = req.body;
    try {
        if (paymentIntentId) {
            const intent = await stripe.paymentIntents.confirm(paymentIntentId);
            return res.send(generateResponse(intent));
        }
        return res.sendStatus(400);
    } catch (e) {
        return res.send({ error: e.message });
    }
});
4