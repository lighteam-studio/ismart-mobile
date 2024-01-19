create table preferences
(
    shop_name TEXT not null
);

create table product
(
    id          VARCHAR(36) not null,
    category_id VARCHAR(36) not null,
    brand       VARCHAR     not null,
    unit        TEXT        not null,
    name        TEXT        not null,
    constraint products_pk
        primary key (id),
    constraint category_id
        check (length(category_id) == 36),
    constraint id
        check (length(id) == 36),
    constraint unit
        check (unit in ('un', 'kg'))
);

create table product_barcode
(
    id         VARCHAR(36) not null,
    product_id VARCHAR(36) not null,
    value      TEXT        not null,
    constraint product_barcode_pk
        primary key (id),
    constraint product_id_fk
        foreign key (product_id) references product
);

create table product_group
(
    id    VARCHAR(36) not null,
    title TEXT        not null,
    constraint product_group_pk
        primary key (id),
    constraint valid_id
        check (length(id) == 36)
);

create table product_category
(
    id       varchar(36) not null,
    name     TEXT        not null,
    group_id TEXT        not null,
    constraint id
        primary key (id),
    constraint group_id
        foreign key (group_id) references product_group,
    constraint valid_id
        check (length(id) == 36)
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

