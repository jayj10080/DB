class ContactsDatatable < ApplicationDatatable

  private

  def data
    contacts.map do |contact|
      [].tap do |column|
        column << contact.first_name
        column << contact.last_name
        column << contact.email
        column << contact.phone
      end
    end
  end

  def count
    Contact.count
  end

  def total_entries
    contacts.total_count
  end

  def contacts
    @contacts ||= fetch_contacts
  end

  def fetch_contacts
    search_string = []

    columns.each do |term|
      search_string << "#{term} like :search"
    end

    contacts = Contact.page(page).per(per_page)
    contacts = contacts.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(first_name last_name email phone)
  end
end