class ContactsDatatable < ApplicationDatatable
  delegate :edit_contact_path, to: :@view

  private

  def data
    contacts.map do |contact|
      [].tap do |column|
        column << contact.first_name
        column << contact.last_name
        column << contact.email
        column << contact.phone

        links = []
        links << link_to('Edit', edit_contact_path(contact))
        links << link_to('Destroy', contact, method: :delete, data: { confirm: 'Are you sure?' })
        column << links.join(' | ')
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

    contacts = Contact.order("#{sort_column} #{sort_direction}")
    contacts = contacts.page(page).per(per_page)
    contacts = contacts.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(first_name last_name email phone)
  end
end