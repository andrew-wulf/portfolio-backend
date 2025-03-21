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
            puts "new portfolio visitor! sending email alert."
            visits = Visit.where("created_at >= ?", 30.days.ago)
        
            data = {}

            visits.each do |v|
                visitor_id = v.visitor_id
                if data.keys.include?(visitor_id)
                    data[visitor_id] +=1
                else
                    data[visitor_id] = 1
                end
            end

            tallies = []

            data.keys.each do |key|
                tallies.push(data[key])
            end

            if tallies.length > 0
                tallies.delete_at(tallies.index(tallies.max))
                visit_count = tallies.sum
            else
                visit_count = visits.length
            end

            
            unique_visitors = data.keys.length

            VisitMailer.new_visitor_email(unique_visitors, visit_count).deliver_now
        end


        links = ["https://chess-hfx7.onrender.com", "https://movie-battle.onrender.com", "https://twitter-clone-frontend-q1pw.onrender.com", 'https://github.com/andrew-wulf/twitter-clone-frontend',
            'https://github.com/andrew-wulf/movie_battle', 'https://github.com/andrew-wulf/chess', "resume_link"]

        if links.include?(site)
            site_visits = Visit.where(site: site, visitor_id: @visitor.id)
            if site_visits.length < 2
                @visitor.update(pending: true)
                sleep(30)
                @visitor.update(pending: false)

                data = @visitor.get_data

                VisitMailer.new_link_email(@visitor.id, site, data).deliver_now
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
