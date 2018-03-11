class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def destroy
  end
end
