class RegistrationResponse < Sinatra::Base

  def self.confirm_unique_identifier(params)
    sources = Source.all
    sources.each do |row|
      if row.identifier == params[:identifier]
        binding.pry
        return {status: 403, message: "Identifier already exists"}
      end
    end
  end

end
