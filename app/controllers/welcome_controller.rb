class WelcomeController < ApplicationController
  def index
    cookies[:curso] = 'Curso de Ruby on Rails - Jackson Pires'
    @meu_nome = params[:nome]
    @curso = "Rails"
  end
end
