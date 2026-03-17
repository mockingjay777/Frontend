#define the function render_smart_views for app to work
import streamlit as st
import pandas as pd
import mysql.connector

def get_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",        # Change if you have a password
        password="", 
        database="hospital"
    )

def render_smart_views():
    st.header("🏥 Smart Clinical Decision Support")

    # --- SECTION 1: REAL-TIME MONITORING (From Trigger/RealTimeView) ---
    st.subheader("📡 Real-Time Department Status")
    conn = get_db_connection()
    df_realtime = pd.read_sql("SELECT * FROM realtimeview", conn)
    
    col1, col2 = st.columns(2)
    with col1:
        st.metric("Current Admitted Patients", df_realtime['Current_Patients'][0])
    with col2:
        st.metric("Recent Readmissions", int(df_realtime['Readmission_Count'][0]))

    # --- SECTION 2: SMART MASTER VIEW (Joined Data) ---
    st.subheader("📋 Integrated Patient Insight (M1 + M25 + M43)")
    df_master = pd.read_sql("SELECT * FROM MasterClinicalInsight", conn)
    
    # Color coding based on the logic we built in the SQL View
    def color_status(val):
        color = 'red' if val == 'High Resource Use' else 'orange' if val == 'Follow-up Required' else 'green'
        return f'color: {color}'

    st.dataframe(df_master.style.applymap(color_status, subset=['Clinical_Status']))

    # --- SECTION 3: STORED PROCEDURE DEMO (High Risk Filter) ---
    st.divider()
    st.subheader("🔍 Clinical Filter: Identify High-Risk Patients")
    dept = st.selectbox("Select Department to scan:", ["Cardiology", "Neurology", "Oncology", "Endocrinology"])
    
    if st.button("Run Clinical Scan"):
        cursor = conn.cursor(dictionary=True)
        # Calling your Stored Procedure!
        cursor.callproc('GetHighRiskPatients', [dept])
        
        # Fetching results from the procedure
        results = []
        for result in cursor.stored_results():
            results.extend(result.fetchall())
        
        if results:
            st.warning(f"Found {len(results)} patients staying > 7 days in {dept}")
            st.table(pd.DataFrame(results))
        else:
            st.success(f"No high-risk patients found in {dept}")
            
    conn.close()