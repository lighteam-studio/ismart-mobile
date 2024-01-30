create table preferences
(
    key   TEXT not null,
    value TEXT,
    constraint preferences_pk
        primary key (key)
);

create table product
(
    category_id VARCHAR(36) not null,
    brand       VARCHAR     not null,
    unit        TEXT        not null,
    name        TEXT        not null,
    product_id  VARCHAR(36) not null,
    constraint products_pk
        primary key (product_id),
    constraint category_id
        check (length(category_id) == 36),
    constraint product_id
        check (length(product_id) == 36),
    constraint unit
        check (unit in ('un', 'kg'))
);

create table product_barcode
(
    product_barcode_id VARCHAR(36) not null,
    product_id         VARCHAR(36) not null,
    value              TEXT        not null,
    constraint product_barcode_pk
        primary key (product_barcode_id),
    constraint product_id_fk
        foreign key (product_id) references product
);

create table product_group
(
    product_group_id VARCHAR(36) not null,
    title            TEXT        not null,
    constraint product_group_pk
        primary key (product_group_id),
    constraint valid_id
        check (length(product_group_id) == 36)
);

create table product_category
(
    product_category_id varchar(36) not null,
    name                TEXT        not null,
    product_group_id    TEXT        not null,
    constraint id
        primary key (product_category_id),
    constraint product_group_id
        foreign key (product_group_id) references product_group,
    constraint valid_id
        check (length(product_category_id) == 36)
);

create table product_image
(
    id         VARCHAR(36) not null,
    data       BLOB        not null,
    mime_type  TEXT        not null,
    name       TEXT        not null,
    product_id VARCHAR(36),
    constraint id
        primary key (id),
    constraint product_id_fk
        foreign key (product_id) references product
);

