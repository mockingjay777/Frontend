# FILE: src/modules/c17-smart-clinical-views/c17_app.py
import streamlit as st
import pandas as pd
# Import your actual module logic from a separate file in this same folder
from dashboard_logic import render_smart_views 

def standalone_demo():
    st.set_page_config(page_title="C17 Demo", layout="wide")
    st.title("Module C17: Smart Clinical Views - Presentation Mode")
    
    # Simulating the 'Doctor' role for the demo
    st.sidebar.success("Logged in as: Doctor (Simulation)")
    
    # Call your core function
    render_smart_views()

if __name__ == "__main__":
    standalone_demo()