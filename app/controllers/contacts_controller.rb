class ContactsController < ApplicationController

  protect_from_forgery with: :null_session, :if => Proc.new {|c| c.request.format == 'application/json' }
  def index
    @contacts = Contact.all
    render :json => @contacts
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render :json => @contact, :status => 201
    else
      render :json => @contact.errors, :status => 422
    end
  end

  def show
    @contact = Contact.find(params[:id])
    render :json => @contact
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      head :no_content
    else
      render :json => @contact.errors, :status => 422
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    head :no_content
  end

private

  def contact_params
    params.fetch(:contact).permit( :name, :email, :phone)
  end
end


