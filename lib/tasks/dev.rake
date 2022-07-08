namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") do
      %x(rails db:drop)  
      end

      show_spinner("Criando BD") do
        %x(rails db:create)
      end
      
      show_spinner("Migrando BD") do
        %x(rails db:migrate)
      end
 
      %x(rails dev:add_miningtypes)
      %x(rails dev:add_coins)
    else 
      puts "Você não esta em ambiente de desenvolvimento"
    end
  end
    
  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas..") do
      coins = [
        {
          description: "Bitcoin",
          acronym: "BTC",
          url_image:"https://pngimg.com/uploads/bitcoin/small/bitcoin_PNG47.png",
          mining_type: MiningType.find_by(acronym: "PoW")
        },
        {
          description: "Ethereum",
          acronym: "ETH", 
          url_image:"https://w7.pngwing.com/pngs/368/176/png-transparent-ethereum-cryptocurrency-blockchain-bitcoin-logo-bitcoin-angle-triangle-logo.png",
          mining_type: MiningType.all.sample
        },
        {
          description: "Dash",
          acronym: "DASH", 
          url_image:"https://w7.pngwing.com/pngs/37/123/png-transparent-dash-bitcoin-cryptocurrency-digital-currency-logo-bitcoin-blue-angle-text.png",
          mining_type: MiningType.all.sample
        }
      ]
      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Cadastra dos tipos de mineração"
  task add_miningtypes: :environment do
    show_spinner ("Cadastrando tipos de mineração...") do
      mining_types = [ 
        {description:"Proof of Work", acronym:'PoW'},
        {description:"Proof of Stake", acronym:'PoS'},
        {description:"Proof of Capacity", acronym:'PoC'}
        ]
  
      mining_types.each do |mining_type|
      MiningType.find_or_create_by!(mining_type)
      end
    end
  end


  private
  def show_spinner(msg_start, msg_end= "Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin # Automatic animation with default interval
    yield 
    spinner.success("Concluido com sucesso!") # Stop animation
  end
end


