# TheBST
A place to safely buy and sell yo-yo's!


## Setup

You'll need:

- ruby
- rails 7
- postgresql

You'll also need to run the following commands if this is your first cloning of this project:

1. ``bundle``
This will install all the required ruby gems and such.

2. ``rake db:migrate``
This will setup the proper tables and such in postgresql

3. ``rake db:seed``
This will setup some required data such as currencies the app knows about.

## Running the project

Then you should be able to run the app like a regular rails app with the command: `rails s` from the root of this project.


## Testing

Anything added to the project needs to be tested. Tests don't necessarily promise everything is working properly, but it does ensure that when we change bits later, we won't break the behavior you specify in the test unless it's on purpose. The project currently has 100% test coverage and any pull requests that cause this to drop will be refused.

## Commits

Commit messages should be informative and use complete sentences. They should help make it clear *why* your change was made, not just what changed. Have a look at other commits in the project before submitting your own.
