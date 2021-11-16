
CREATE SEQUENCE public.items_item_id_seq_1;

CREATE TABLE public.Items (
                Item_ID INTEGER NOT NULL DEFAULT nextval('public.items_item_id_seq_1'),
                Name VARCHAR NOT NULL,
                CONSTRAINT itemid PRIMARY KEY (Item_ID)
);


ALTER SEQUENCE public.items_item_id_seq_1 OWNED BY public.Items.Item_ID;

CREATE SEQUENCE public.historical_price_price_id_seq_1;

CREATE TABLE public.Historical_Price (
                Item_ID INTEGER NOT NULL,
                Price_ID VARCHAR NOT NULL DEFAULT nextval('public.historical_price_price_id_seq_1'),
                Start_Date DATE NOT NULL,
                Price REAL NOT NULL,
                CONSTRAINT price_id_ PRIMARY KEY (Item_ID, Price_ID)
);


ALTER SEQUENCE public.historical_price_price_id_seq_1 OWNED BY public.Historical_Price.Price_ID;

CREATE SEQUENCE public.item_picture_item_picture_id_seq;

CREATE TABLE public.Item_Picture (
                Item_ID INTEGER NOT NULL,
                Item_Picture_ID VARCHAR NOT NULL DEFAULT nextval('public.item_picture_item_picture_id_seq'),
                Picture BYTEA NOT NULL,
                CONSTRAINT item_picture_id PRIMARY KEY (Item_ID, Item_Picture_ID)
);


ALTER SEQUENCE public.item_picture_item_picture_id_seq OWNED BY public.Item_Picture.Item_Picture_ID;

CREATE TABLE public.Customer (
                BroncoID INTEGER NOT NULL,
                FirstName VARCHAR NOT NULL,
                LastName VARCHAR NOT NULL,
                DOB DATE NOT NULL,
                Phone VARCHAR NOT NULL,
                CONSTRAINT broncoid PRIMARY KEY (BroncoID)
);


CREATE SEQUENCE public.orders_order_id_seq;

CREATE TABLE public.Orders (
                BroncoID INTEGER NOT NULL,
                Order_ID INTEGER NOT NULL DEFAULT nextval('public.orders_order_id_seq'),
                Date DATE NOT NULL,
                Time TIME NOT NULL,
                Original_Price_Total REAL NOT NULL,
                Discount_Price_Total REAL NOT NULL,
                Status VARCHAR NOT NULL,
                CONSTRAINT order_id PRIMARY KEY (BroncoID, Order_ID)
);


ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.Orders.Order_ID;

CREATE TABLE public.Order_Items (
                BroncoID INTEGER NOT NULL,
                Order_ID INTEGER NOT NULL,
                Item_ID INTEGER NOT NULL,
                Price_ID VARCHAR NOT NULL,
                Price REAL NOT NULL,
                CONSTRAINT orderitems PRIMARY KEY (BroncoID, Order_ID, Item_ID, Price_ID)
);


CREATE TABLE public.Professor (
                BroncoID INTEGER NOT NULL,
                Department VARCHAR NOT NULL,
                Office VARCHAR NOT NULL,
                Research VARCHAR NOT NULL,
                CONSTRAINT bronco_id PRIMARY KEY (BroncoID)
);


CREATE TABLE public.Student (
                BroncoID INTEGER NOT NULL,
                Enter_Date DATE NOT NULL,
                Major VARCHAR NOT NULL,
                Minor VARCHAR NOT NULL,
                Grad_Date DATE NOT NULL,
                CONSTRAINT broncoid PRIMARY KEY (BroncoID)
);


ALTER TABLE public.Order_Items ADD CONSTRAINT items_order_items_fk
FOREIGN KEY (Item_ID)
REFERENCES public.Items (Item_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Item_Picture ADD CONSTRAINT items_item_picture_fk
FOREIGN KEY (Item_ID)
REFERENCES public.Items (Item_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Historical_Price ADD CONSTRAINT items_historical_price_fk
FOREIGN KEY (Item_ID)
REFERENCES public.Items (Item_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Order_Items ADD CONSTRAINT historical_price_order_items_fk
FOREIGN KEY (Item_ID, Price_ID)
REFERENCES public.Historical_Price (Item_ID, Price_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Student ADD CONSTRAINT customer_student_fk
FOREIGN KEY (BroncoID)
REFERENCES public.Customer (BroncoID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Professor ADD CONSTRAINT customer_professor_fk
FOREIGN KEY (BroncoID)
REFERENCES public.Customer (BroncoID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Orders ADD CONSTRAINT customer_orders_fk
FOREIGN KEY (BroncoID)
REFERENCES public.Customer (BroncoID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Order_Items ADD CONSTRAINT orders_order_items_fk
FOREIGN KEY (BroncoID, Order_ID)
REFERENCES public.Orders (BroncoID, Order_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
