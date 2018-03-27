require 'rails_helper'

RSpec.describe Recipe, type: :model do

  context "Presence validation: " do
    describe "email" do
      it "does not save user without an email" do
        user = User.new
        user.valid?
        expect(user.errors[:email]).to be_present
      end

     it "does not have an error when a user has an email" do
        user = User.new(email: 'email@email.com')
        user.valid?
        expect(user.errors[:email]).to_not be_present
      end
    end
    
    describe "password" do
      it "does not save user without a password" do
        user = User.new
        user.valid?
        expect(user.errors[:password]).to be_present
      end

     it "does not have an error when a user has a password" do
        user = User.new(password_digest: 'Password12345')
        user.valid?
        expect(user.errors[:password_digest]).to_not be_present
      end
    end
  end 

  context "Uniqueness validation: " do
     it "does not allow signing up with same email" do
        user1 = User.new(name: 'user1', email: 'email@email.com', password_digest: 'Password12345' )
        user1.save
        user2 = User.new(name: 'user2', email: 'email@email.com', password_digest: 'Password12345' )
        user2.save
        expect(user2.errors[:email]).to eq(["has already been taken"])
      end
  end

  context "New user" do
    it "creates a user creates a user with a default role of user" do
      user = User.new(name: 'user1', email: 'email@email.com', password_digest: 'Password12345' )
      user.save
      expect(user.role).to eq("user")
    end
  end

  context "user?" do
    it "checks if user role is equal to user" do
      user = User.new(name: 'user1', email: 'email@email.com', password_digest: 'Password12345', role: "user" )
      user.save
      expect(user.user?).to eq(true)
    end
  end

  context "admin" do
    describe "admin?" do
      it "checks if user role is equal to admin" do
        user = User.new(name: 'user1', email: 'email@email.com', password_digest: 'Password12345', role: "admin" )
        user.save
        expect(user.admin?).to eq(true)
      end
    end
    describe "set_admin" do
      it "sets user role to admin" do
        user = User.new(name: 'user1', email: 'email@email.com', password_digest: 'Password12345', role: "user" )
        user.save
        user.set_admin
        expect(user.role).to eq("admin")
      end
    end
  end

end


