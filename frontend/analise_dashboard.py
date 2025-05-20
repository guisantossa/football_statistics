import streamlit as st
import pandas as pd
from streamlit_echarts import st_echarts
from datetime import datetime

class AnaliseDashboard:
    def __init__(self):
        self.data = self.load_data()

    def load_data(self):
        df = pd.read_csv("frontend/bets.csv")
        df["data_aposta"] = pd.to_datetime(df["data_aposta"])
        return df

    def filter_data(self, start_date, end_date):
        return self.data[
            (self.data["data_aposta"] >= pd.to_datetime(start_date)) &
            (self.data["data_aposta"] <= pd.to_datetime(end_date))
        ]

    def pie_chart(self, df, column, status):
        filtered = df[df["status"] == status]
        data = filtered[column].value_counts()
        options = {
            "title": {
                "text": f"{status.upper()} por {column}",
                "left": "center",
                "textStyle": {"color": "#ffffff"},
            },
            "tooltip": {"trigger": "item"},
            "legend": {
                "orient": "vertical",
                "left": "left",
                "textStyle": {"color": "#fff"},
            },
            "series": [
                {
                    "name": column,
                    "type": "pie",
                    "radius": "60%",
                    "data": [{"value": int(v), "name": str(k)} for k, v in data.items()],
                    "emphasis": {
                        "itemStyle": {
                            "shadowBlur": 10,
                            "shadowOffsetX": 0,
                            "shadowColor": "rgba(0, 0, 0, 0.5)"
                        }
                    }
                }
            ]
        }
        st_echarts(options=options, height="400px")

    def render_filters(self):
        st.markdown("### 🗓️ Filtro de Datas")
        col1, col2 = st.columns(2)
        min_date = self.data["data_aposta"].min()
        max_date = self.data["data_aposta"].max()

        with col1:
            start_date = st.date_input("Data Inicial", value=min_date, min_value=min_date, max_value=max_date)
        with col2:
            end_date = st.date_input("Data Final", value=max_date, min_value=min_date, max_value=max_date)

        return start_date, end_date

    def render_dashboard(self):
        st.markdown(
            "<style>body { background-color: #0e1117; color: white; }</style>",
            unsafe_allow_html=True
        )
        st.title("📊 Dashboard de Apostas Esportivas")

        with st.container():
            start_date, end_date = self.render_filters()
            filtered_data = self.filter_data(start_date, end_date)

        sections = [
            ("combinacoes", "Combinações"),
            ("odd", "Linha de Odds"),
            ("tipo_aposta", "Tipo de Aposta"),
        ]

        for coluna, titulo in sections:
            st.markdown(f"## 🔍 {titulo}")
            col1, col2 = st.columns(2)
            with col1:
                self.pie_chart(filtered_data, coluna, "green")
            with col2:
                self.pie_chart(filtered_data, coluna, "red")

if __name__ == "__main__":
    dashboard = BetDashboard()
    dashboard.render_dashboard()
