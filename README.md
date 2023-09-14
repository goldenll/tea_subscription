<h1>Tea Subscription</h1>

**DB schema**
![Database Schema](app/assets/images/db.png)

**How to install the project?**<br>
Fork and clone this repo<br>
Run bundle install<br>
Run rails db:{create,migrate,seed}<br>
Usebundle exec rspec to run the test suite<br><br>


<h2>API JSON CONTRACT</h2>
Description of API endpoints for front end application<br><br>


**A customer can subscribe to a tea subscription:**<br>
POST /api/v1/customers/:customer_id/subscriptions/:subscription_id<br><br>

Success Response (201 Created):<br><br>

Status: 201 Created<br>
Description: Successful response with customer and subscription information.<br>
Data Format: A hash containing a customer hash and a subscription hash, each containing relevant attributes.<br>
Status: 201 Created<br>

![](app/assets/images/new_subscription.png)

**A customer can cancel a tea subscription:**<br>
PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id<br><br>

Success Response (200 OK):<br><br>

Status: 200 OK<br>
Description: Successful response with confirmation message.<br>
Data Format: A hash containing a confirmation message.<br>
Status: 200 OK<br>

![](app/assets/images/cancel_subscription.png)


**A customer can see their subscription history:**<br>
GET /api/v1/customers/:customer_id/subscriptions<br><br>

Success Response (200 OK):<br><br>

Status: 200 OK<br>
Description: Successful response that displays active and canceled subscriptions.<br>
Data Format: An array of hashes containing subscription history.<br>
Status: 200 OK<br>

![](app/assets/images/subscription_history.png)
