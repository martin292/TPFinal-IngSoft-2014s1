Camilo::App.controllers :events do

  get :index do
    @events = Event.all(:account => current_account)
    render 'events/index'
  end

  get :new do
    @event = Event.new
    render 'events/new'
  end

  get '/my' do
    @events = Event.all(:account => current_account)
    render 'events/index'
  end

  get :show do
    @event = Event.get(params[:id].to_i)
    render 'events/show'
  end

  post :create do
    @event = Event.new(params[:event])
    @event.account = current_account

    if @event.max == " " || @event.max.nil?
      @event.max = 0
    end

    if @event.save && @event.max >= 0 && @event.check_email
      @event.short_url = UrlShortener.for_default_url.shorten("events/rate/#{@event.slug}").short_url
      @event.save
      redirect(url(:events, :show, :id => @event.id))
    else
      flash.now[:error] = "Error: ambos campos son requeridos"
      if @event.max.is_a?(String) || @event.max < 0
        flash.now[:error] = "Error: la cantidad de participantes debe ser un numero positivo"
      end
      
      if !@event.check_email
        flash.now[:error] = "Error: debe ingresar una direccion de e-mail valida"
      end
      render 'events/new'
    end
  end

  get '/:event_slug/edit' do
    @event = Event.find_by_slug(params[:event_slug])
    if(@event.nil?)
      @message = "El evento buscado no existe."
      render 'events/message'
    else
      render 'events/edit'
    end
  end

  get '/rate/:event_slug' do
    @event = Event.find_by_slug(params[:event_slug])
    if(@event.nil?)
      @message = "El evento buscado no existe."
      render 'events/message'
    elsif(@event.date > Date.today)
      @message = "El evento no se encuentra disponible para evaluar porque no ha sido dictado"
      render 'events/message'
    else
      if @event.max > 0 && @event.ratings.size == @event.max
        @message = "Este evento alcanzo la cantidad maxima de evaluaciones."
        render 'events/message'
      elsif @event.max == 0 || @event.ratings.size != @event.max
        render 'events/rate'
      end
    end
  end

  post '/rate/:event_id' do
    @event = Event.find_by_slug(params[:event_id])
    rating = Rating.for_event(@event)
    rating.value = params[:value]
    rating.comment = params[:comment] 
    rating.save
    
    @event.nueva_evaluacion
    @event.account.hay_notificacion = 1
    @event.save
    
    @message = "Gracias por su evaluacion"
    render 'events/message'
  end

  get '/:event_slug/ratings' do
    @event = Event.find_by_slug(params[:event_slug])   
    if(@event.account == current_account) 
      
      @event.chekear_evaluacion
      @event.account.hay_notificacion = 0
      @event.save
      
      render 'events/ratings'
    else
      return 403
    end
  end

  
  get '/:event_tag/comparation' do
    @events = Event.all(:tag => params[:event_tag])
    if (@events.nil? || @events.size == 1)
      @message = "Este evento no se puede comparar porque no hay eventos que contengan el mismo tag"
      render 'events/message'
    else
      render 'events/comparation'
    end
  end
    

  get '/:event_slug/comments' do
    @event = Event.find_by_slug(params[:event_slug])   
    if(@event.account == current_account) 
      render 'events/comments'
    else
      return 403
    end
  end

  post '/:event_id/update' do
    @event = Event.get(params[:event_id].to_i)
    if @event && (@event.account == current_account)
      if @event.update(params[:event])
        flash[:success] = t(:update_success, :model => 'Event', :id =>  "#{params[:id]}")
        redirect(url(:events, :show, :id => @event.id))
      else
        flash.now[:error] = "Error: ambos campos son requeridos y la fecha debe ser posterior a hoy"
        render 'events/edit'
      end
    else
      flash[:warning] = t(:update_warning, :model => 'event', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Events"
    event = Event.get(params[:id].to_i)
    if event
      if event.destroy
        flash[:success] = t(:delete_success, :model => 'Event', :id => "#{params[:id]}")
      else
        flash[:error] = t(:delete_error, :model => 'event')
      end
      redirect url(:events, :index)
    else
      flash[:warning] = t(:delete_warning, :model => 'event', :id => "#{params[:id]}")
      halt 404
    end
  end

end
