class VisitMailer < ApplicationMailer

    def new_visitor_email(unique_visitors=0, visit_count=0)
        @visit_count = visit_count
        @unique_visitors = unique_visitors

        mail(from: "Alert <alerts@andrew-wulf-portfolio.com>", to: ENV['ALERTS_RECIPIENT'], subject: "New Visitor!")
    end

    def new_link_email(id, site, data)
        @visitor_id = id
        @site = site
        @data = data

        @msg = 'A visitor viewed your resume for the first time!'
        subj = "Visitor viewed your resume"

        apps = {"https://chess-hfx7.onrender.com" => 'Chess', "https://movie-battle.onrender.com" => "Movie Battle",  "https://twitter-clone-frontend-q1pw.onrender.com" => "Twitter Clone"}
        github_links = {
            'https://github.com/andrew-wulf/twitter-clone-frontend' => "Twitter Clone Github",
            'https://github.com/andrew-wulf/movie_battle' => "Movie Battle Github",
            'https://github.com/andrew-wulf/chess' => "Chess Github"
        }

        if apps.keys.include?(site)
            @msg = "A visitor viewed your #{apps[site]} App for the first time!"
            subj = "Visitor viewed your #{apps[site]} app"
        end

        if github_links.keys.include?(site)
            @msg = "A visitor viewed your #{apps[site]} Github Page for the first time!"
            subj = "Visitor viewed your Github: #{apps[site]}"
        end

        mail(from: "Alert <alerts@andrew-wulf-portfolio.com>", to: ENV['ALERTS_RECIPIENT'], subject: subj)
    end
end
