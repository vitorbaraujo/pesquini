# File: users_controller.rb
# Purpose: Implementation of Users Controller
# License: LGPL. No copyright.

# This controller contains the logic involving creating and setting attributes
# for the correspondent view of a single user

class UsersController < ApplicationController

  # name: new
  # explanation: this method instantiates a new user
  # parameters:
  # - none
  # return: object of type User
  def new
    @user = User.new

    return @user
  end

end
