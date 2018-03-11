class ContactsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: ContactsDatatable.new(view_context) }
    end
  end

  def edit
    # @contact = Contact.find(params[:id])
  end

  def destroy
  end
end
