class Api::V1::TestController < ApplicationController
    before_action :authorize_request
    before_action :authorize_role
    
    def index
        @test = Test.all
        render json: @test
    end
    def create
        json = JSON.parse(params[:QuestionData])
        tests = Test.new(name: params[:nameTest],description: params[:descriptionTest],question_quantity: json.length())
            if tests.save
                if json
                    json.each do |n|
                        question = Question.new(name: n["nameQuestion"],description: n["descriptionQuestion"],test_id: tests.id)
                        if question.save
                            n["option"].each do |x|
                                optionQuestion = OptionQuestion.new(name: x["nameOption"],correct: x["correct"],question_id: question.id)
                                optionQuestion.save
                            end
                        end
                    end
                end
                render json: tests, status: :created
            else
                render json: { error: tests.errors, test: tests }, status: :error
            end
    end
    def edit
        @optionQuestion = {}
        @test = Test.find_by(id: params[:id])
        if @test
            @question = Question.where(:test_id => @test.id)
            if @question
                @question.each do |n|
                    @optionQuestion[n.id] = OptionQuestion.where(:question_id => n.id)
                end
            end
        end
        render json: {'test': @test, 'question': @question,'optionQuestion': @optionQuestion }
    end

    def update
        json = JSON.parse(params[:QuestionData])
        test = Test.find_by(id: params[:id])
        test.update(name: params[:nameTest],description: params[:descriptionTest],question_quantity: json.length())
            if test.save
                json.each do |n|
                    question = Question.find_by(test_id: test.id)
                    question.update(name: n["nameQuestion"],description: n["descriptionQuestion"],test_id: test.id)
                    if question.save
                        n["option"].each do |x|
                            optionQuestion = OptionQuestion.find_by(question_id: question.id)
                            optionQuestion.update(name: x["nameOption"],correct: x["correct"],question_id: question.id)
                            optionQuestion.save
                        end
                    end
                end
                render json: test, status: :created
            else
                render json: { error: test.errors, test: test }, status: :error
        end 
    end

    def destroy
        Test.find(params[:id]).destroy  
        render json: { message: 'removed' }
    end
end
