class estatisticas():
    def __init__(self):
        pass
    @staticmethod
    def app():
        from front_dashboard import FootballDashboard
        app = FootballDashboard()
        app.run()
    
class analise():
    def __init__(self):
        pass
    @staticmethod
    def app():
        from analise_dashboard import AnaliseDashboard
        dashboard = AnaliseDashboard()
        dashboard.render_dashboard()

    
class bancas():
    def __init__(self):
        pass
    @staticmethod
    def app():
        pass