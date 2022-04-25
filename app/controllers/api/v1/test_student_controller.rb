class Api::V1::TestStudentController < ApplicationController
    before_action :authorize_request
        
        def index
            @test = Test.all
            render json: @test
        end
        def show
            @optionQuestion = {}
            @test = Test.find_by(id: params[:id])
            if @test
                @question = Question.where(:test_id => @test.id)
                if @question
                    @question.each do |n|
                        @optionQuestion[n.id] = OptionQuestion.select("id,name,question_id").where(:question_id => n.id)
                    end
                end
            end
        render json: {'test': @test, 'question': @question,'optionQuestion': @optionQuestion }
    end
    def solution
        json = JSON.parse(params[:solution])
         result = []
        test = Test.find_by(id: json["test"]["id"])
        json["test"]["question"].each do |n|
            question = Question.where(:id => n["id"])
            optionQuestion = OptionQuestion.where(:id => n["option_id"])
            result << { "question#{n["id"]}" => { 'your answer' => optionQuestion[0].correct } }
        end
        render json: result
    end
end
