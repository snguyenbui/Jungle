require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be able to create a user' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      expect(@user.id).to be_present
    end

    describe "Password" do
      it 'must have a password' do
        @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password_confirmation: "hunter2!")
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
        expect(@user.errors.full_messages).to contain_exactly("Password can't be blank", "Password can't be blank", "Password confirmation doesn't match Password", "Password confirmation doesn't match Password", "Password is too short (minimum is 8 characters)")
      end

      it 'must have a password confirmation' do
        @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "")
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
        expect(@user.errors.full_messages).to contain_exactly("Password confirmation doesn't match Password", "Password confirmation doesn't match Password", "Password confirmation doesn't match Password")
      end

      it 'password must match confirmation' do
        @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunt")
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
        expect(@user.errors.full_messages).to contain_exactly("Password confirmation doesn't match Password", "Password confirmation doesn't match Password", "Password confirmation doesn't match Password")
      end

      it 'password must be at least 8 characters' do
        @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2", password_confirmation: "hunter2")
        @user.save
        expect(@user.errors.full_messages).not_to be_empty
        expect(@user.errors.full_messages).to contain_exactly("Password is too short (minimum is 8 characters)")
      end
    end

    it 'should check if email already exists, case insensitive' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2", password_confirmation: "hunter2")
      @user.save
      @otherUser = User.new(first_name: "Test", last_name: "User", email:"SAMPLE@domain.com", password: "hunter2", password_confirmation: "hunter2")
      @otherUser.save
      expect(@otherUser.errors.full_messages).not_to be_empty
    end

    it 'should require an email' do
      @user = User.new(first_name: "Test", last_name: "User", password: "hunter2", password_confirmation: "hunter2")
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
    end

    it 'should require a first name' do
      @user = User.new(last_name: "User", email:"sample@domain.com", password: "hunter2", password_confirmation: "hunter2")
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
    end

    it 'should require a last name' do
      @user = User.new(first_name: "Test", email:"sample@domain.com", password: "hunter2", password_confirmation: "hunter2")
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
    end
  end

  describe ".authenticate_with_credentials" do
    it 'should be able to validate a user' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      @user2 = User.authenticate_with_credentials("sample@domain.com", "hunter2!")
      expect(@user2.id).to be_present
    end

    it 'should return nil if not able to validate password' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      @user2 = User.authenticate_with_credentials("sample@domain.com", "hunter2")
      expect(@user2).to be_nil
    end

    it 'should return nil if not able to validate email' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      @user2 = User.authenticate_with_credentials("sample@domain.coms", "hunter2!")
      expect(@user2).to be_nil
    end

    it 'should return user if email has spaces before or after' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      @user2 = User.authenticate_with_credentials("   sample@domain.com   ", "hunter2!")
      expect(@user2.id).to be_present
    end

    it 'should return user if email found, case insensitive' do
      @user = User.new(first_name: "Test", last_name: "User", email:"sample@domain.com", password: "hunter2!", password_confirmation: "hunter2!")
      @user.save!
      @user2 = User.authenticate_with_credentials("sample@DOMAIN.com", "hunter2!")
      expect(@user2.id).to be_present
    end
  end
end
