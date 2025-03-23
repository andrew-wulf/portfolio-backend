class VisitsController < ApplicationController


    def create
        site = params[:site]

        if site == nil
            render json: {errors: "missing params"}, status: :bad_request
            return
        end

        if site[-1] == '/'
            site = site.chop
        end

        new_visitor = false

        @visitor = Visitor.find_by(id: params[:visitor_id])
        if @visitor 
            visitor_id = @visitor.id
        
        else 
            new_visitor = true
            @visitor = Visitor.new
            if @visitor.save 
                visitor_id = @visitor.id         
            else
                render json: {errors: @visitor.errors.full_messages}, status: :bad_request
                return
            end
        end
        
        visit = Visit.new(site: site, visitor_id: visitor_id)

        

        # # Intialize the email class
        # ms_client = Mailersend::Client.new(ENV['MAILERSEND_API_KEY'])
        # ms_email = Mailersend::Email.new(ms_client)

        # # Add parameters
        # ms_email.add_recipients("email" => ENV['ALERTS_RECIEPIENT'])
        # ms_email.add_from("email" => "alerts@andrew-wulf-portfolio.com", "name" => "Alert")
        # ms_email.add_subject("New Visitor!")
        # personalization = {visits: '5'}
        # ms_email.add_personalization(personalization)
        # ms_email.add_template_id("pr9084zo8jelw63d")

        # # Send the email
        # ms_email.send

        if visit.save
            render json: {visitor_id: visitor_id}, status: :created
        else
            render json: {errors: visit.errors.full_messages}, status: :bad_request
        end


        if new_visitor
            puts "new portfolio visitor! Sending email alert after delay."

            AsyncVisitorEmailJob.set(wait: 30.minutes).perform_later(@visitor)
        end


        links = ["https://chess-hfx7.onrender.com", "https://movie-battle.onrender.com", "https://twitter-clone-frontend-q1pw.onrender.com", 'https://github.com/andrew-wulf/twitter-clone-frontend',
            'https://github.com/andrew-wulf/movie_battle', 'https://github.com/andrew-wulf/chess', "resume_link"]

        if links.include?(site)
            site_visits = Visit.where(site: site, visitor_id: @visitor.id)
            puts @visitor.pending
            if site_visits.length < 2 && @visitor.pending == false
                @visitor.pending = true
                @visitor.save
                
                puts "Visitor Viewed a link for the first time! Sending email alert in 30 minutes."
                AsyncLinkEmailJob.set(wait: 60.minutes).perform_later(@visitor, site)
            end
        end

    end


    def index

        if params[:password] === ENV['DEV_PASS']
            @visitors = Visitor.all
            render :index
        else 
            render json: {message: "not authorized."}, status: :bad_request
        end

    end


end
