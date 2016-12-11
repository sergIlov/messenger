class UsersController < ApplicationController
  autocomplete :user, :email, where: { is_blocked: false }

end