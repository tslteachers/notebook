class NotesController < ApplicationController

  def index
    @current_user = User.find_by_id(session[:login_id])
    if @current_user != nil
      @notes = @current_user.notes
    end
  end

  def show
    @note = Note.find_by_id(params[:id])
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new
    @note.description = params[:description]
    @note.user_id = session[:login_id]

    if @note.save
      redirect_to notes_url
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find_by_id(params[:id])
  end

  def update
    @note = Note.find_by_id(params[:id])
    @note.description = params[:description]

    if @note.save
      redirect_to notes_url
    else
      render 'new'
    end
  end

  def destroy
    @note = Note.find_by_id(params[:id])
    @note.destroy

    respond_to do |format|
      format.html do
        redirect_to notes_url
      end
      format.js do
        # $("#note_9").slideUp();
        render :js => '$("#note_' + @note.id.to_s + '").slideUp();'
      end
    end
  end
end
