# Backyard Basket

### A two sided marketplace project

#### By: Nick Saltis

[Deployed Site: https://backyard-basket.herokuapp.com/](https://backyard-basket.herokuapp.com/)

[Github Repository: https://github.com/NicholasSaltis/Backyard_Basket](https://github.com/NicholasSaltis/Backyard_Basket)

------

## The Problem: 

Anyone who has ever lived with a healthy and productive fruit tree on their property understands the problems that arises come the tree's fruiting season: More fruit than you could ever possibly eat. fruit falling off and rotting away on the ground. Offloading boxes and bags of fruit to anyone you know, anyone who'll take it. And still having some left over. Home growers reap the rewards of their fruit trees, veggie patches, chicken coops or beehives but due to the seasonal nature of crops, the supply coming from the garden can outstrip the demand from the home owners. 

The flip side of this issue is people living in suburban or metropolitan areas without access to a backyard to grow their own produce or without access to someone they know who has excess produce and loves to give it away. Fresh fruit and vegetables are available in grocery stores or even growers markets but often at an inflated price due to shipping, supply, or being imported. The impacts of this may result in an increased grocery bill for a shopper, reduction or exclusion of fresh fruit and veggies from families diets due to cost/inconvenience and an increased burden on the environment by relying on commercial growers to supply more buyers. 

------

## The Solution 

Get these two groups in contact with each other so that home growers have people that can take excess produce off their hands and shoppers can find local, fresh, homegrown produce cheaply and easily. Allow growers to be able to display and advertise their produce in an easy to access way, and for people wanting to find and connect with local growers, an easy way to see growers in their local area, view their produce and contact the grower to inquire, barter or trade for their produce. By setting up this marketplace it eases the burden on growers come harvesting season, puts fresh produce within reach of people eager to include fruit and veg in their diet at a reduced cost to their budget and the environment, and encourages people to eat healthier. It also improves social health by providing an opportunity for people to connect with one another over home grown produce. It may also encourage homeowners with space on their property to start growing produce which has a multitude of environmental benefits such as increased biodiversity/bioavailability for local bee populations, decreased reliance on commercial agriculture and improved soil health. 

------

## Backyard Basket overview

#### Purpose: 

* Provide an open and accessible marketplace for growers and shoppers to connect and negotiate trading of produce.
* Allow Growers to list and display their produce so that shoppers can view them with the freedom to control stock and price and other descriptions.
* Allow shoppers to find growers in their local area to simplify their browsing experience. 

#### Features: 

* User registration and authorization using devise to improve site security and restrict profile and product CRUD operations to their respective users as well as unsuring messages get sent to right user.
* Profile and address editing so that users can keep their information up to date. 
* User can create products with full CRUD functionality and view them all in their personal "Pantry"
* Address geocoding using geocoder to allow for filtering of profiles based on their address to improve experience for a signed in user when they browse for local growers.
* Combined view profile pages that are accessed via a card on the browse page. Displays the profiles user name, location at the suburb level, contact form to send a message to the profile's user and a card deck of all the products that the viewed profile has created. 
* View product page that displays all information about the product. 
* Image upload for a profile image and product images, stored remotely with amazon s3.
* User messaging initiated from the view growers page using acts_as_messageable gem. Each user can view all their received messages via the inbox page and select a message to view it and then send a reply message. 

#### Site Map:

![Sitemap](/docs/Sitemap.png)

#### Screenshots:

#### Target Audience: 

* People who have an abundance of home grown produce, eg. fruit, vegetables, honey or eggs and may be looking for a better use for any excess harvest than rotting and going to waste, or having to call up or drop by friends or relatives places to offload the excess. 
* People looking to find home grown produce in their local area that can supplement their grocery shopping but do not already know a prolific grower nearby.
* Ideal for Permaculturalists or people concerned with sustainablity and fostering community spirit. 

#### Tech Stack: 

* Ruby on Rails web framework for front and backend functionality
* Postgresql relational database
* Heroku for hosting and deployment. 
* AWS S3 for remote object storage, used for image upload
* Github for source control and CD/CI in conjunction with heroku
* Bootstrap css framework for page styling

------

## User stories:

* As a person interested in homegrown produce I want to be able to view produce in my local area so that I do not have to travel far if it is something I want to get.
* As a user interested in signing up for the app I want the process to be clear and simple so that my time is respected.
* As a signed-in user, I want to be able to customise and edit my profile so that I can keep my information up to date and useful for promoting myself as a local grower.
* As a user wanting a good deal on local produce I want to be able to contact a seller to negotiate a deal so that a deal that works for both of us can be struck.
* As a shopper looking for local produce, I want to be able to view the details and images of produce so that I can see the quality and how fresh it is.
* As a Grower, I want to be able to add, edit and delete products that I want to sell/give away so that my pantry information is up to date and relevant to avoid redundant messages.
* As a Grower I want to be able to upload images of my produce so that I can better advertise my produce.
* As a user I want to be able to see a profile image of other users so that I might know what they look like before we meet to exchange produce. 
* As a grower I want to be able to choose to list an item with a price or without a price so that people have an understanding of my expectations for offers before a shopper makes one. 
* As a User I want my profile and products to only be editable by myself so that other users cannot interfere with my information.
* As a User I want my address to be hidden partially so that my home address is not publicly displayed.
* As a Shopper i want to be able to contact a grower and send them a message detailing what I want so that I can initiate a negotiation for their produce.
* As a User I want to be able to view all my received messages and respond to the sender If I'd like.

------

## Wireframes:

![Browse_Page](/docs/Browse_Page.png)

![Home Page](/docs/Home Page.png)

![View_Inbox_page](/docs/View_Inbox_page.png)

![View_Profile_Page](/docs/View_Profile_Page.png)

![Wireframes_Mobile_View](/docs/Wireframes_Mobile_View.png)

![Your_Pantry_Page](/docs/Your_Pantry_Page.png)

------

## Initial ERD:

![Initial_ERD_Backyard_Basket](/docs/Initial_ERD_Backyard_Basket.png)

------

## MVC Components: 

#### Models: 

*  User: handled by devise and declares the devise modules to be activated in the app: database_authenticatable, registerable recoverable, rememberable, validatable. Also sets up has_one association with profile and dependant destroy preventing orphaned records.
* Profile: Main table that all other tables reference. accepts nested attributes for address which allows for the profile create form to also create an address record. Connects to active record has_one_attached with name profile_img to be called by controllers or views. Validates profile data sent from controller for presence and correct length and returns error to form view if not validated.
* Product: has_many_attached active record images to be called via .pictures. Validates data input from product controller for presence, correct and limited integer or string values. uses validates_timeliness gem for date time validation. prevents harvest date from being after current date and expiry date from being before tomorrow's date. Sends error messages back through to the form view if validation fails.
* Address: Created via nested form profile form which first goes to profile controller per strong params check then profile model before being redirected to address model via accepts_nested_attributes_for. Uses geocoder gem that runs after address fields are succesfully validated. Calls address method to concatenate address fields into a usable string which is sent to map search api via geocoder and returns with latitude and longitude coordinates which are then added to the address record. Validates address fields and returns errors to form if incorrect.

#### Controllers:

* Application controller has before action get_profile_id which passes navbar partial via application.html.erb the current signed in user's profile id. Also redirects to new profile path immediately after a user signs up with the app. `current_user` is a devise method that return the currently signed in User instance `.profile` finds the associated profile object.

* Home: Has two actions: index for displaying the home page view. Browse action connects to browse.html.erb. It passes two different instance variable through to the view depending it a user is signed in or not. If a user is signed in it queries geocoder with the current signed in users profile address which returns a lists of address objects within a radius of the current user's address. It also preloads the address's associated profiles and those profile's profile images as they are called in the view in a loop which without preloading would cause an N+1 issue.

  `@nearby_profiles = current_user.profile.address.nearbys(5).includes(:profile, profile: :profile_img_attachment)`.

   If the user is not signed in it just passes all profiles and preloads address and profile images instead.

  `@profiles = Profile.all.includes(:address, :profile_img_attachment)`

* Messages: uses acts_as_messageable gem to create new message records based on the params passed from the message forms in the views. strong params via before_action :message_params permits only allowed params from view. new_message method calls send_message which creates an entry in the message table based on current user's profile, and then the params passed from view. If a response_type param is passed of value reply then the method redirects to messages#index. Index is the user's inbox passing @messages which is all the current user's profiles received messages to the messages/index.html.erb view

* Products: Scaffolded crud functionality with one change; @products which is passed from the products#index action returns all associated products of the current signed in user's profile.

  `@products = current_user.profile.products.all`

* Profiles: profiles#new action also calls `@profile.build_address` to allow nested form attributes passed from new profile form to be validated and run through the address model to be geocoded. Address attributes are added to the profile params private method to permit only required address params, as well as profile params. Create action redirects instead to home#index is profile is successfully validated and saved. 

#### Views: 

* Application: renders navbar partial to be displayed on each page. Is passed @profile_id variable from application controller and then passed to the navbar partial as a local variable. 
* Index and Browse: controlled by home controller, browse is passed instance variables of either nearby address objects or profile objects, depending if the user is signed in or not. Browse makes multiple calls to both asscosiated profiles or addresses or passed instance variable attributes such as user_name. 
* Messages: messages#index or inbox page iterates over @messages which is passed from the messages controller. it makes calls to return attributes of the current message, but also makes an association call for the message's senders profile which is preloaded in the controller to prevent N+1 calls. Show makes calls to the passed message objects attributes. The form sends the params through to new_message in the messages controller.
* Products. index is only shows products belonging to signed in user. new and edit render the same form partial. show checks if current user is associated with shown products and if not hides the redirection buttons, mainly edit. It also calls attached? method on the passeed product to check if it has any images and if it does it creates an image carousel with all the attached pictures. 
* Profile: form partial uses simple form and fields_for address to pass address attributes to be validated and entered at the same time as profile. same partial is used for edit action. profile show page has two different layouts/information based on if current signed in user matches the profile. If matched, just shows the profile image and information with a redirect to edit profile. If not displays profile information with a more friendly layout, a contact form that sends to the messages#new_message controller and all of the shown profile's associated products in a card deck format. 

------

## 3rd Party Services:

* AWS S3: used to allow active record to store image objects remotely in an s3 bucket. accessed using an AWS IAM user and supplying the secret access keys to the app or to the config vars in heroic. Ensures high standard of data integrity and prevents against dataloss. Connected using was-sdk-s3 gem.
* Geocoder: gem that has access to 40 geolocation API's. Allows for filtering of address objects based on the address attributes being passed to through the API and returning latitude and longitude coordinates that allow a radius to be set within which other geocoded objects can be returned.
* bootstrap and jquery for responsive site design using javascript libraries sent by jquery CDN. 

#### Gems 

* bootstrap
* jquery-rails
* simple_form
* devise
* geocoder
* country_select
* acts-as-messageable
* validates_timeliness

------

## Model Associations: 

#### User:

* has_one profile

#### Profile:

* belongs_to user
* has_one address
* has_many products
* Has_one_attached profile_img
* Has_many sent_messageable, as: sent_messageable
* Has_many received_messageable, as: received_messageable

#### Address:

* belongs_to profile

#### Products:

* belongs_to profile
* Has_many_attached pictures
* Acts_as_messageable

#### Messages:

* Belongs_to sent_messagable, polymorphic: true
* Belongs_to received_messagable, polymorphic: true 

------

## Database Associations:

#### User:

* Parent table, no foreign keys

#### Profile:

* user_id, null: false, type: bigint  references user table id attribute

#### Address:

* profile_id, null: false, type: bigint  references profile table id attribute

#### Products

* profile_id, null:false, type: bigint, references profile table id attribute

#### Messages

* two polymorphic associations, received_messageable and sent_messageable. both are referenced by profiles table. 
* received_messageable_type, type: string
* received_messageable_id, type: bigint
* sent_messageable_type, type: string
* sent_messageable_id, type: bigint

------

## Database Schema: 

![Final_ERD_Backyard_Basket](/docs/Final_ERD_Backyard_Basket.png)

------

## Project Management: 

#### [Public Trello Board](https://trello.com/b/TeKHvMAf/local-growers-app)

Trello was used to manage this project. I implemented a number of lists, the first group being planning and timetabling: Project Milestones for important dates to keep a track of, User stories for guest, buyer and seller to be translated into backlog items and planning list to keep track of planning steps. The second group of lists forming the task by task progression tracker. Cards start in the backlog and get pulled through In Progress, Implemented and Deployed. Some cards had checklists for relevant subtasks that needed to be completed were added where applicable. Cards in the backlog represent either a feature/functionality of the app (eg. Profile edit functionality) or a process that needs to be completed (eg. Deploy to heroku). In progress column means that I have started working on the task in the development environment but it is not finished. Implemented means that the task is working in the development environment. Deployed means that the task is working on the deployed site. 

![Trello_board1](/docs/Trello_board1.png)

![Trello_board2](/docs/Trello_board2.png)