# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def team
    roles.where(name: :leader).first.resource
  end

  private

  def assign_default_role
    add_role(:player) if roles.blank?
  end
end
