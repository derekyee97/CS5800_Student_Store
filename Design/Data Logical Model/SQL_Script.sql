
CREATE SEQUENCE public.items_itemid_seq;

CREATE TABLE public.Items (
                ItemID INTEGER NOT NULL DEFAULT nextval('public.items_itemid_seq'),
                Name VARCHAR NOT NULL,
                Type VARCHAR NOT NULL,
                CONSTRAINT items_pk PRIMARY KEY (ItemID)
);


ALTER SEQUENCE public.items_itemid_seq OWNED BY public.Items.ItemID;

CREATE SEQUENCE public.historicalprice_priceid_seq;

CREATE TABLE public.HistoricalPrice (
                PriceID INTEGER NOT NULL DEFAULT nextval('public.historicalprice_priceid_seq'),
                ItemID INTEGER NOT NULL,
                Start DATE NOT NULL,
                Price REAL NOT NULL,
                CONSTRAINT historicalprice_pk PRIMARY KEY (PriceID, ItemID)
);


ALTER SEQUENCE public.historicalprice_priceid_seq OWNED BY public.HistoricalPrice.PriceID;

CREATE SEQUENCE public.itempicture_itempictureid_seq;

CREATE TABLE public.ItemPicture (
                ItemPictureID INTEGER NOT NULL DEFAULT nextval('public.itempicture_itempictureid_seq'),
                Picture BYTEA NOT NULL,
                ItemID INTEGER NOT NULL,
                CONSTRAINT itempicture_pk PRIMARY KEY (ItemPictureID)
);


ALTER SEQUENCE public.itempicture_itempictureid_seq OWNED BY public.ItemPicture.ItemPictureID;

CREATE TABLE public.Customer (
                BroncoID INTEGER NOT NULL,
                FirstName VARCHAR NOT NULL,
                LastName VARCHAR NOT NULL,
                DOB DATE NOT NULL,
                Phone VARCHAR NOT NULL,
                CONSTRAINT broncoid PRIMARY KEY (BroncoID)
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
                Major VARCHAR NOT NULL,
                Minor VARCHAR,
                EnterDate DATE NOT NULL,
                GradDate DATE NOT NULL,
                CONSTRAINT customer_id PRIMARY KEY (BroncoID)
);


CREATE SEQUENCE public.orders_orderid_seq;

CREATE TABLE public.Orders (
                OrderID INTEGER NOT NULL DEFAULT nextval('public.orders_orderid_seq'),
                BroncoID INTEGER NOT NULL,
                Date DATE NOT NULL,
                Time TIME NOT NULL,
                Status VARCHAR NOT NULL,
                OriginalPrice REAL NOT NULL,
                DiscountPrice REAL NOT NULL,
                CONSTRAINT order_id PRIMARY KEY (OrderID, BroncoID)
);


ALTER SEQUENCE public.orders_orderid_seq OWNED BY public.Orders.OrderID;

CREATE SEQUENCE public.orderitems_orderitemid_seq;

CREATE TABLE public.OrderItems (
                OrderItemID INTEGER NOT NULL DEFAULT nextval('public.orderitems_orderitemid_seq'),
                OrderID INTEGER NOT NULL,
                BroncoID INTEGER NOT NULL,
                ItemID INTEGER NOT NULL,
                Price REAL NOT NULL,
                PriceID INTEGER NOT NULL,
                Quantity INTEGER NOT NULL,
                CONSTRAINT orderitems_pk PRIMARY KEY (OrderItemID)
);


ALTER SEQUENCE public.orderitems_orderitemid_seq OWNED BY public.OrderItems.OrderItemID;

ALTER TABLE public.OrderItems ADD CONSTRAINT items_orderitems_fk
FOREIGN KEY (ItemID)
REFERENCES public.Items (ItemID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ItemPicture ADD CONSTRAINT items_itempicture_fk
FOREIGN KEY (ItemID)
REFERENCES public.Items (ItemID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.HistoricalPrice ADD CONSTRAINT items_historicalprice_fk
FOREIGN KEY (ItemID)
REFERENCES public.Items (ItemID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.OrderItems ADD CONSTRAINT historicalprice_orderitems_fk
FOREIGN KEY (PriceID, ItemID)
REFERENCES public.HistoricalPrice (PriceID, ItemID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Orders ADD CONSTRAINT customer_orders_fk
FOREIGN KEY (BroncoID)
REFERENCES public.Customer (BroncoID)
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

ALTER TABLE public.OrderItems ADD CONSTRAINT orders_orderitems_fk
FOREIGN KEY (OrderID, BroncoID)
REFERENCES public.Orders (OrderID, BroncoID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
