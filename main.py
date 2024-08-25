from PIL import ImageTk
from customtkinter import *
from CTkTable import *
from tkinter import *
from tkinter import ttk
from request import *
import tkinter.messagebox as mb
from params import params
import warnings


warnings.filterwarnings("ignore")

app = CTk()
app.resizable(0, 0)
app.title("Tour App")

set_appearance_mode("dark")
x, y = (app.winfo_screenwidth() // 2 - 1070 // 2) + 50, (app.winfo_screenheight() // 2 - 730 // 2)
app.geometry(f'{1070}x{730}+{x}+{y}')

hot = CTkButton(master=app, text="")
tree = CTkTable(master=app)
ttktree = ttk.Treeview()

sidebar_frame = CTkFrame(app, fg_color="#38AF68", border_color="#87FFB7", border_width=2)
sidebar_frame.pack_propagate(False)
sidebar_frame.pack(fill="y", anchor="w", side="left")

global dic
dic = params[0]


def on_entry_change(*args):
    global data
    filter_text = entry_var.get().lower()
    if filter_text != '':
        newvalues = [(dic['columns'])]
    else:
        # newvalues = [(dic['columns'])] + get_by_name(dic['table_name'])
        newvalues = []
    for item in data:
        if any(str(i).lower().startswith(filter_text) for i in
               item):
            newvalues.append(item)
    tree.configure(values=newvalues)
    tree.values = newvalues
    global ttktree
    for row in ttktree.get_children():
        ttktree.delete(row)
    for dat in newvalues[1:]:
        ttktree.insert("", END, values=dat)
    # data = tree.values


global filter_id
filter_id = None


def schedule_filter(*args):
    global filter_id
    if filter_id is not None:
        app.after_cancel(filter_id)
    filter_id = app.after(1000, on_entry_change)


def button_click(dict):
    global title
    title.configure(text=dict['title'])
    for widget in table_frame.winfo_children():
        widget.destroy()
    create_table(dict)


def inp(*args):
    global dict
    global dic

    name = dic['table_name']
    column = dic['bd_columns'][args[0][0]['column']]
    id_ = tree.values[args[0][0]['row']][0]

    toplevel_window = CTkToplevel()
    toplevel_window.title(f"Edit")
    x, y = (app.winfo_screenwidth() // 2 - 500 // 2) + 100, (app.winfo_screenheight() // 2 - 200 // 2)
    toplevel_window.geometry(f'{500}x{200}+{x}+{y}')
    toplevel_window.grab_set()
    main_view = CTkFrame(master=toplevel_window, fg_color="transparent")
    # main_view.pack_propagate(False)
    main_view.pack()
    entry = CTkEntry(master=main_view, border_color='#87FFB7', border_width=1, width=400)
    entry.pack(pady=30)
    entry.insert(0, args[0][0]['value'])

    def update():
        value = entry.get()
        if update_by_name(name, column, value, id_):
            toplevel_window.destroy()
            button_click(dic)

    frame1 = CTkFrame(main_view)
    frame1.pack(side="left")
    frame2 = CTkFrame(main_view)
    frame2.pack(side="right")
    CTkButton(master=frame1, text="Edit", fg_color="#38AF68", border_color='#269251', hover_color='#269251',
              border_width=2, width=175, command=update).pack()
    CTkButton(master=frame2, text="Cancel", fg_color="#38AF68", border_color='#269251', hover_color='#269251',
              border_width=2, width=175, command=toplevel_window.destroy).pack()


def create_table(dict):
    global hot
    global dic
    global data
    global sort
    hot.destroy()
    rev = [False] * len(dict['columns'])

    def hotsort():
        values = [columns] + find_hot()
        tree.configure(values=values)
        for row in ttktree.get_children():
            ttktree.delete(row)
        for data in tree.values[1:]:
            ttktree.insert("", END, values=data)

    if dict['title'] == 'Tours':
        # image = ImageTk.PhotoImage(ImageTk.Image.open(r'fire.png'))
        img_data = ImageTk.Image.open("fire.png")
        image = CTkImage(light_image=img_data, dark_image=img_data, size=(20, 20))
        hot = CTkButton(master=title2_frame, text='', text_color="#fff", fg_color="#2A8C55",
                        hover_color="#207244", width=50, command=hotsort, image=image)
        hot.pack(side='left')
    else:
        hot.destroy()

    def sort(col, reverse, key=str):
        m = [(ttktree.set(k, col), k) for k in ttktree.get_children()]
        m.sort(reverse=reverse, key=lambda t: key(t[0]))
        for index, (_, k) in enumerate(m):
            ttktree.move(k, "", index)
        rev[col] = not rev[col]
        ttktree.heading(col, command=lambda: sort(col, not reverse, key=key))

    columns = dict['columns']

    def p(dict, column):
        sort(column, rev[column], dict['sort'][column])
        s = ttktree.get_children("")
        ss = [columns]
        for element in s:
            ss.append(ttktree.item(element)['values'])
        tree.configure(values=ss)

    global ttktree
    table_data = [columns] + get_by_name(dict['table_name'])
    ttktree = ttk.Treeview(master=table_frame, columns=dict['columns'], show="headings", selectmode="browse")
    for row in ttktree.get_children():
        ttktree.delete(row)
    for column in dict['columns']:
        ttktree.heading(column, text=column, command=lambda: sort(dict['columns'].index(column), False,
                                                                  key=dict['sort'][dict['columns'].index(column)]))
    for data in table_data[1:]:
        ttktree.insert("", END, values=data)
    global tree
    tree = CTkTable(master=table_frame, values=table_data, header_color="#2A8C55", hover_color="#2A8C55",
                    wraplength=220, anchor="W",
                    command=lambda *args: p(dict, args[0]['column']) if args[0]['row'] < 1 else inp(args))

    tree.edit_row(0, text_color="#fff", hover_color="#50d786")
    for width in dict['column_width']:
        tree.edit_column(dict['column_width'].index(width), width=width)
    tree.pack(expand=True)
    data = tree.values
    dic = dict
    data = tree.values
    p(dict, 0)


def new():
    def add_to_bd(arr):
        values = [i.get() for i in arr]
        if add_by_name(dic['table_name'], dic['bd_columns'], values):
            toplevel_window.destroy()
            button_click(dic)

    global dict
    global dic
    dict = dic
    toplevel_window = CTkToplevel()
    toplevel_window.title(f"Add new row")
    x, y = (app.winfo_screenwidth() // 2 - 400 // 2) + 100, (
            app.winfo_screenheight() // 2 - (50 * len(dict['columns'][1:]) + 50) // 2)
    toplevel_window.geometry(f'{400}x{50 * len(dict['columns'][1:]) + 50}+{x}+{y}')
    toplevel_window.grab_set()
    main_view = CTkFrame(master=toplevel_window)
    main_view.pack_propagate(False)
    main_view.pack(fill=BOTH, expand=1)

    x = 25

    for column in dict['columns'][1:]:
        entry = CTkEntry(master=main_view, border_color='#87FFB7', border_width=1, width=200, placeholder_text=column)
        entry.pack(pady=(x, 0))
        x = x % 15
    button = CTkButton(master=main_view, text="Add", fg_color="#38AF68", border_color='#269251', hover_color='#269251',
                       border_width=2, width=100,
                       command=lambda arr=list(main_view.children.values())[1:]: add_to_bd(arr))
    button.pack(pady=10)


def delete():
    dialog = CTkInputDialog(text="Input index", title="Delete row")
    dialog._button_fg_color = '#2A8C55'
    dialog._button_hover_color = '#207244'
    dialog._entry_border_color = '#87FFB7'
    x, y = (app.winfo_screenwidth() // 2 - 500 // 2) + 150, (app.winfo_screenheight() // 2 - 100 // 2)
    dialog.geometry(f'{500}x{200}+{x}+{y}')
    ind = dialog.get_input()
    if ind != '':
        confirmation = mb.askyesno("Подтверждение", "Вы уверены, что хотите удалить?")
        if not confirmation:
            return
        del_by_index(dic['table_name'], ind)
        button_click(dic)


def filtr():
    def filt(arr):
        global data
        values = [i.get() for i in arr]
        if any(i != '' for i in values):
            new_values = tree.values
            for i in tree.values[1:]:
                if all(str(j) != values[i.index(j)] for j in i):
                    new_values.remove(i)
            tree.values = new_values
            tree.configure(values=new_values)
        else:
            new_values = [(dic['columns'])] + get_by_name(dic['table_name'])
            tree.values = new_values
            tree.configure(values=new_values)

        data = new_values
        global ttktree
        for row in ttktree.get_children():
            ttktree.delete(row)

        for dat in data[1:]:
            ttktree.insert("", END, values=dat)

    global dict
    global dic
    dict = dic
    toplevel_window = CTkToplevel()
    toplevel_window.title(f"Filter")
    x, y = (app.winfo_screenwidth() // 2 - 400 // 2) + 100, (
            app.winfo_screenheight() // 2 - (50 * len(dict['columns'][1:]) + 100) // 2)
    toplevel_window.geometry(f'{400}x{50 * len(dict['columns'][1:]) + 50}+{x}+{y}')
    toplevel_window.grab_set()
    main_view = CTkFrame(master=toplevel_window)
    main_view.pack_propagate(False)
    main_view.pack(fill=BOTH, expand=1)

    x = 25

    for column in dict['columns']:
        entry = CTkEntry(master=main_view, border_color='#87FFB7', border_width=1, width=200, placeholder_text=column)
        entry.pack(pady=(x, 0))
        x = x % 15
    button = CTkButton(master=main_view, text="Filter", fg_color="#38AF68", border_color='#269251',
                       hover_color='#269251',
                       border_width=2, width=100,
                       command=lambda arr=list(main_view.children.values())[1:]: filt(arr))
    button.pack(pady=10)


for dict in params:
    CTkButton(master=sidebar_frame, text=dict['title'], fg_color="transparent", font=("Arial Bold", 17),
              hover_color="#207244",
              anchor="w", command=lambda dict=dict: button_click(dict)).pack(anchor="w", padx=(20, 0),
                                                                             pady=(20, 0))

main_view = CTkFrame(master=app, width=1070, height=700, corner_radius=0)
main_view.pack_propagate(False)
main_view.pack(side="left")

title_frame = CTkFrame(master=main_view, fg_color="transparent")
title_frame.pack(anchor="ne", fill="x", padx=27, pady=(15, 0))

title2_frame = CTkFrame(master=main_view, fg_color="transparent")
title2_frame.pack(fill="x", anchor="ne", padx=27, pady=(0, 0))

title = CTkLabel(master=title_frame, text="Tours", font=("Arial Black", 25), text_color="#38AF68")
title.pack(anchor="nw", side="left", pady=6)

entry_var = StringVar()
entry_var.trace_add('write', lambda *args: schedule_filter())

newbtn = CTkButton(master=title_frame, text="+ New", font=("Arial Black", 15), text_color="#fff", fg_color="#2A8C55",
                   hover_color="#207244", command=new)
newbtn.pack(anchor="ne", side="right", fill=None, pady=0)

delbtn = CTkButton(master=title2_frame, text="- Del", font=("Arial Black", 15), text_color="#fff", fg_color="#2A8C55",
                   hover_color="#207244", command=delete)
delbtn.pack(fill=None, side="right", anchor="ne", pady=(0, 0))

entry = CTkEntry(master=title_frame, width=305, placeholder_text="Search", border_color="#2A8C55",
                 border_width=2,
                 textvariable=entry_var, placeholder_text_color='#fff')
entry.pack(side="left", padx=(20, 0), pady=(15, 15))

filter = CTkButton(master=title_frame, text="Filter", width=60, font=("Arial Black", 13), text_color="#fff",
                   fg_color="#2A8C55",
                   hover_color="#207244", command=filtr)
filter.pack(side='left', padx=10)

table_frame = CTkScrollableFrame(master=main_view, fg_color="transparent")
table_frame.pack(expand=True, fill="both", padx=27, pady=21)

create_table(params[0])

app.mainloop()
