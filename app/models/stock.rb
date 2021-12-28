class Stock < ApplicationRecord

    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
        secret_token: 'secret_token',
        endpoint: 'https://sandbox.iexapis.com/v1'
        )
        begin
            #created a company_name variable to store name of company 
            company = client.company(ticker_symbol)
            company_name = company.company_name
            #created a new Stock object to store price, name and ticker symbol for any Stock
            Stock.new(ticker: ticker_symbol, name: company_name, last_price: client.price(ticker_symbol))
        rescue => exception
        return nil
        end
    end

end
