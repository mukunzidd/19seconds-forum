class PostsController < ApplicationController
	before_action :find_post, only: [:show, :update, :edit, :destroy]
	before_action :authenticate_user!, except: [:show, :index]
	def index
		@posts = Post.all.order("created_at DESC")	
	end

	def new
		@post = current_user.posts.build
		@current_user.posts << @post
	end

	def create
		@post = current_user.posts.build(post_params) 

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
	end

	def edit
		
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'			
		end
	end

	def delete
		@post.destroy
		redirect_to root_path		
	end

	private
	def find_post
		@post = Post.find(params[:id])		
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
