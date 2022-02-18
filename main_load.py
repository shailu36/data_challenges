# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


# Press the green button in the gutter to run the script.

import pandas as pd

from load import insert_esg_data

if __name__ == '__main__':
    import pandas as pd
    import psycopg2

    conn = psycopg2.connect(
        database="data_challenges", user='postgres', password='Badger!0', host='192.168.1.152', port='5432'
    )

    # df = pd.read_csv("es.txt", sep="\t")
    # insert_esg_data(conn,df,'data.esg_scores')
    #df1 = pd.read_csv("id_map.txt", sep="\t")
    #insert_esg_data(conn, df1, 'data.id_map')
    df2 = pd.read_csv("sp500.txt")
    insert_esg_data(conn, df2, 'data.sp500')
