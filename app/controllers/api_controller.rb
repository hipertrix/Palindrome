class ApiController < ApplicationController
	
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json   
  $retuns_palindrome = {true => 'is a palindrome', false => 'is not a palindrome' }




  def test  
  	test_palindrome = is_palindrome(params[:p])
  	Test.create(question: params[:p], answer: test_palindrome ) 
  	@ret = {success: true, msg: $retuns_palindrome[test_palindrome] }
  	return_data
  end



  def list  
  	list = Test.all.order(created_at: :desc)
  	@ret = {success: true, list: list }
  	return_data
  end



  def destroy 
  	@test = Test.find(params[:id])
  	if @test.destroy
	  	@ret = {success: true, msg: 'Successfully removed!' } 
	end
	return_data
  end 
 


  def return_data
    @ret = {success: false, :msg=>"Nothing was processed"} if @ret.nil?
    render json: @ret
    return false
  end   



private

	def is_palindrome(phase) 
	 new_phase = phase.downcase.to_s.gsub(/\W/,'')
	 return (new_phase.reverse.to_s == new_phase.to_s)
	end


end 