## That One Episode :: Sitcom Mailer App
[![Circle CI](https://circleci.com/gh/skuhlmann/cheers-mail.svg?style=svg)](https://circleci.com/gh/skuhlmann/cheers-mail)

You know when your friend is all, "Hey man, do you remember that episode of Seinfeld when Kramer and Newman make sausage in Jerry's apartment?". Well, this app is meant to be that friend.

[That One Episode in production](http://www.thatoneepisode.us/)

### Installation

Clone That One Episode to your local machine with:

  $ git clone git@github.com:skuhlmann/cheers-mail.git

Install gems:

  $ bundle install

Then setup the database:

  $ rake db:setup

Launch the server with:

  $ unicorn

Go to localhost:8080


### Misc

Requires a SendGrid account for email delivery.

Created as a learning project to practice with mailing list managment and api consumption.
