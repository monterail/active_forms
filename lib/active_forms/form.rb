# encoding: UTF-8

class ActiveForms::Form < ActiveForms::Mapper
  columns :name, :code, :url, :status, :activeReleaseCode, :activeReleaseName, :title, :isPrintable

  class << self
    def all(params = {})
      response = ActiveForms::Request.get("forms", params)

      hashes = response["forms"]["form"]
      hashes = [hashes] if hashes.is_a?(Hash)

      objects = hashes.nil? ? [] : hashes.map { |attributes| new(attributes) }
    end
  end

  def full_url
    if url.starts_with?("http")
      url
    else
      host = ActiveForms.configuration.url[:protocol] + "://" + ActiveForms.configuration.url[:host]
      host << "/" << ActiveForms.configuration.base_url << "/" << url
    end
  end

  def active?
    status == "active"
  end

  def inactive?
    status == "inactive"
  end
end